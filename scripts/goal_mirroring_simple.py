#!/usr/bin/env python
import rospkg
import rospy
import sys
import time
import os
import time
import random

from std_msgs.msg import String
from std_srvs.srv import Empty, EmptyResponse
from rosplan_knowledge_msgs.srv import *
from rosplan_dispatch_msgs.srv import DispatchService, DispatchServiceResponse, PlanningService, PlanningServiceResponse, ParsingService
from diagnostic_msgs.msg import KeyValue
from rosplan_knowledge_msgs.msg import KnowledgeItem
from rosplan_dispatch_msgs.msg import ActionDispatch
from collections import defaultdict
from timeit import default_timer as timer
from sklearn.metrics import confusion_matrix

############
# THE REST #
############

# get path of pkg
rospack = rospkg.RosPack()
rospy.init_node("coordinator")

# load parameters
planner_command = rospy.get_param('~planner_command', "")
domain_path = rospy.get_param('~domain_path', "")
problem_path = rospy.get_param('~problem_path', "")
data_path = rospy.get_param('~data_path', "")
hyp = rospy.get_param('~hypothesis_goals', "")
obs = rospy.get_param('~observations', "")
temp_obs = rospy.get_param('~temp_observations', "")
initial_state = rospy.get_param('~initial_state', "")
log_file = rospy.get_param('~log_file', "")
real_goal = rospy.get_param('~real_goal', "")


# wait for services
rospy.wait_for_service('/rosplan_problem_interface/problem_generation_server')
rospy.wait_for_service('/rosplan_planner_interface/planning_server_params')
rospy.wait_for_service('/rosplan_plan_dispatcher/dispatch_plan')
rospy.wait_for_service('/rosplan_parsing_interface/parse_plan')


plan = ""
cost_plans = []
goals_ideal_plans = dict()
goals_o_plans = defaultdict(list)
classification_metrics = defaultdict(list)

def get_object_type(string):
    objects = ["region", "crop", "livestock", "produce", "box", "location", "robot"]
    for obj in objects:
        if obj in string:
            return str(obj)


def callback(data):
    global plan
    plan = data.data


def callback_action(data):
    print(data.data)


# Get the total cost of each plan
def get_plan_cost(plan):
    action_list = plan.splitlines()
    cost = 0.0
    # get plan duration
    if len(action_list) ==0:
        return cost
    # Add the cost of each action
    for action in action_list:
        cost = cost + 1

    return round(cost, 3)

# Add or remove the goals in the kb
def add_or_remove_goal(split_line, Add):
    for action in split_line:
        # The goal name
        kus = KnowledgeUpdateServiceRequest()
        # If add is true, add the goals to kb
        if Add:
            kus.update_type = 1
        # Otherwise, remove the goals in kb
        else:
            kus.update_type = 3

        kus.knowledge.knowledge_type = 1
        kus.knowledge.attribute_name = action.split(' ')[0][1:]

        # if 1 object in the goal like (taken-image region_4)
        if len(action.split(' ')) == 2:
            kv = KeyValue()
            # Formatting to remove the ')' at the end
            if '\n' in action.split(' ')[1]:
                kv.value = action.split(' ')[1][:-3]
            else:
                kv.value = action.split(' ')[1][:-1]

            kv.key = get_object_type(kv.value)
            kus.knowledge.values.append(kv)

        # If 2 objects in a goal like (contains box_4 crop_2)
        elif len(action.split(' ')) == 3:
            # Formatting to remove the ')' at the end
            kv = KeyValue()
            kv.value = action.split(' ')[1]
            kv.key = get_object_type(kv.value)
            kus.knowledge.values.append(kv)

            kv = KeyValue()
            # if '\n' in action.split(' ')[2][:-3]:
            if '\n' in action.split(' ')[2]:
                kv.value = action.split(' ')[2][:-3]
            else:
                kv.value = action.split(' ')[2][:-1]
            kus.knowledge.values.append(kv)
            kv.key = get_object_type(kv.value)

        kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
        kb = kuc(kus)
        if not kb and Add:
            rospy.logerr("KCL: (%s) Goal was not added!" % rospy.get_name())
        elif not kb and not Add:
            rospy.logerr("KCL: (%s) Goal was not removed!" % rospy.get_name())


def get_instances_of_type(instance_type):
    # create a connection to the service
    get_instances_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/instances', GetInstanceService)

    # create a request object
    req = GetInstanceServiceRequest()

    # set the type of the instance
    req.type_name = instance_type

    # call the service to get the instances of the specific type
    instances = get_instances_service(req).instances

    # return the instances
    return instances

# Returns the current kb state with the instances, propositions, functions, timed knowledge and metrics
def get_knowledge():
    rospy.wait_for_service('/rosplan_knowledge_base/state/instances')
    rospy.wait_for_service('/rosplan_knowledge_base/state/propositions')
    rospy.wait_for_service('/rosplan_knowledge_base/state/functions')
    rospy.wait_for_service('/rosplan_knowledge_base/state/timed_knowledge')
    rospy.wait_for_service('/rosplan_knowledge_base/state/metric')
    try:
        # get instances
        get_instances_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/instances', GetInstanceService)
        types = ["region", "base", "ground", "aerial", "box", "crop", "livestock", "position", "charging-station",
                 "produce"]
        instances = []
        for instance_type in types:
            inst = get_instances_of_type(instance_type)
            for instance in inst:
                ki = KnowledgeItem()
                ki.knowledge_type = 0
                ki.instance_type = instance_type
                ki.instance_name = instance

                # add the knowledge item to the list
                instances.append(ki)

        # get propositions
        get_propositions_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/propositions', GetAttributeService)
        propositions = get_propositions_service().attributes

        # get functions
        get_functions_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/functions', GetAttributeService)
        functions = get_functions_service().attributes
        # get timed knowledge
        get_timed_knowledge_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/timed_knowledge', GetAttributeService)
        timed_knowledge = get_timed_knowledge_service().attributes

        # get timed knowledge
        get_metric_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/metric', GetMetricService)
        metrics = get_metric_service().metric

        return instances, propositions, functions, timed_knowledge, metrics

    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)


# Completely wipes the knowledge base
def clear_kb():
    rospy.wait_for_service('/rosplan_knowledge_base/clear')
    try:
        clear_service = rospy.ServiceProxy('/rosplan_knowledge_base/clear', Empty)
        resp1 = clear_service()
    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)


# Revert the state of the knowledgebase to the initial state
def reinitialise_kb(instances, propositions, functions, timed_knowledge, metrics):
    try:
        kus_instances = KnowledgeUpdateServiceArrayRequest()
        update_type_array = []
        for i in range(len(instances)):
            update_type_array.append(0)

        kus_instances.update_type = update_type_array
        kus_instances.knowledge = instances


        kus_propositions = KnowledgeUpdateServiceArrayRequest()
        update_type_array = []
        for i in range(len(propositions)):
            update_type_array.append(0)

        kus_propositions.update_type = update_type_array
        kus_propositions.knowledge = propositions


        kus_functions = KnowledgeUpdateServiceArrayRequest()
        update_type_array = []
        for i in range(len(functions)):
            update_type_array.append(0)

        kus_functions.update_type = update_type_array
        kus_functions.knowledge = functions


        kus_timed_knowledge = KnowledgeUpdateServiceArrayRequest()
        update_type_array = []
        for i in range(len(timed_knowledge)):
            update_type_array.append(0)

        kus_timed_knowledge.update_type = update_type_array
        kus_timed_knowledge.knowledge = timed_knowledge


        kus_metrics = KnowledgeUpdateServiceRequest()

        kus_metrics.update_type = 4
        kus_metrics.knowledge = metrics

        kuc_array = rospy.ServiceProxy('/rosplan_knowledge_base/update_array', KnowledgeUpdateServiceArray)
        kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)

        # Add the instances, propositions, functions, timed knowledge and metrics to the knowledge base
        kuc_array(kus_instances)
        kuc_array(kus_propositions)
        kuc_array(kus_functions)
        kuc_array(kus_timed_knowledge)
        kuc(kus_metrics)

        rospy.loginfo("KCL: (%s) Calling problem generation" % rospy.get_name())
        pg = rospy.ServiceProxy('/rosplan_problem_interface/problem_generation_server', Empty)
        if not pg():
            rospy.logerr("KCL: (%s) No problem was generated!" % rospy.get_name())

    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)


def generate_problem_and_plan():
    rospy.loginfo("KCL: (%s) Calling problem generation" % rospy.get_name())
    pg = rospy.ServiceProxy('/rosplan_problem_interface/problem_generation_server', Empty)
    if not pg():
        rospy.logerr("KCL: (%s) No problem was generated!" % rospy.get_name())

    rospy.loginfo("KCL: (%s) Calling planner" % rospy.get_name())
    pi = rospy.ServiceProxy('/rosplan_planner_interface/planning_server_params', PlanningService)
    pi_response = pi(domain_path, problem_path, data_path, planner_command, True)

    if not pi_response:
        rospy.logerr("KCL: (%s) No response from the planning server." % rospy.get_name())
        return False
    if not pi_response.plan_found:
        rospy.loginfo("KCL: (%s) No plan could be found." % rospy.get_name())
        return False
    else:
        rospy.loginfo("KCL: (%s) Plan was found." % rospy.get_name())
        return True

# Execute the plans via simulated actions
def execute_plan():
    # rospy.sleep(25.0)
    rospy.loginfo("KCL: (%s) Calling plan parser" % rospy.get_name())
    rospy.wait_for_service('/rosplan_parsing_interface/parse_plan_from_file')

    try:
        parse_plan_service = rospy.ServiceProxy('/rosplan_parsing_interface/parse_plan_from_file', ParsingService)

        response = parse_plan_service(temp_obs)

        rospy.sleep(3)

        dispatch_plan_service = rospy.ServiceProxy('/rosplan_plan_dispatcher/dispatch_plan', DispatchService)
        pd_response = dispatch_plan_service()
        if not pd_response:
            rospy.logerr("KCL: (%s) No response from the dispatch server." % rospy.get_name())
            return False
        else:
            rospy.loginfo("KCL: (%s) Plan was executed." % rospy.get_name())
            return True

    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)


# Create a temporary file with the added observations to parse the file
def write_temp_obs(count_obs):
    with open(obs, "r+") as input_file:
        with open(temp_obs, "w") as output_file:
            for i, line in enumerate(input_file):
                if i < count_obs:
                    output_file.write(line)
        output_file.close()
    input_file.close()

def plan_already_solved_metric_ff():
    plan_solved = False
    path = data_path + "plan.pddl"
    with open(path, "r+") as plan_file:
        for line in plan_file:
            if "ff: goal can be simplified to TRUE. The empty plan solves it" in line:
                plan_solved = True
                return plan_solved
    plan_file.close()
    return plan_solved

def return_distance(start_pos, end_pos, ground):
    with open(problem_path, "r+") as problem_file:
        lines = problem_file.readlines()
    problem_file.close()

    for line in lines:
        if ground:
            if "distance_location" in line:
                # Find everything in b/w parenthesis
                temp_robot = line[line.find("(")+1:line.rfind(")")]
                temp_arr = temp_robot.split(' ')
                
                if temp_arr[2] == start_pos and temp_arr[3][:-1] == end_pos:
                    return int(temp_arr[4])
        else:
            if "distance" in line:
                temp_robot = line[line.find("(")+1:line.rfind(")")]
                temp_arr = temp_robot.split(' ')
                if temp_arr[2] == start_pos and temp_arr[3][:-1] == end_pos:
                    return int(temp_arr[4])

def update_mission_length(mission_length, amount):
    # Remove mission length and replace it by increasing it
    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 2
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "mission-length"
    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Mission length was not removed!" % rospy.get_name())

    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 0
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "mission-length"
    kus.knowledge.function_value = mission_length + amount
    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Mission Length was not added!" % rospy.get_name())

def update_battery_amount(battery_amount, velocity, battery_discharge, value):
    # Remove battery amount and replace it by decrease it according to velocity
    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 2
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "battery-amount"
    
    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Battery amount was not removed!" % rospy.get_name())

    kus = KnowledgeUpdateServiceRequest()
    kus.update_type = 0
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "battery-amount"
    
    kus.knowledge.function_value = battery_amount - ((value/velocity) * battery_discharge)

    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Battery amount was not added!" % rospy.get_name())

def recharge_battery(battery_capacity):
    # Remove battery amount and replace it by decrease it according to velocity
    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 2
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "battery-amount"
    
    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Battery amount was not removed!" % rospy.get_name())

    kus = KnowledgeUpdateServiceRequest()
    kus.update_type = 0
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "battery-amount"
    kus.knowledge.function_value = battery_capacity

    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Battery amount was not added!" % rospy.get_name())


def update_input_amount(input_amount):
    # Remove food amount and replace it by decrease it
    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 2
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "input-amount"

    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Input amount was not removed!" % rospy.get_name())

    kus = KnowledgeUpdateServiceRequest()
    kus.update_type = 0
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "input-amount"
    kus.knowledge.function_value = input_amount - 1

    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Input amount was not added!" % rospy.get_name())

def recharge_input(input_capacity):
    # Remove battery amount and replace it by decrease it according to velocity
    kus = KnowledgeUpdateServiceRequest()
    # Remove knowledge flag
    kus.update_type = 2
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "input-amount"
    
    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Input amount was not removed!" % rospy.get_name())

    kus = KnowledgeUpdateServiceRequest()
    kus.update_type = 0
    kus.knowledge.knowledge_type = 2
    kus.knowledge.attribute_name = "input-amount"
    kus.knowledge.function_value = input_capacity

    kuc = rospy.ServiceProxy('/rosplan_knowledge_base/update', KnowledgeUpdateService)
    kb = kuc(kus)
    
    if not kb:
        rospy.logerr("KCL: (%s) Input amount was not added!" % rospy.get_name())


def update_numeric_values_kb():
    with open(temp_obs, "r+") as input_file:
        obs_lines = input_file.readlines()
    input_file.close()

    for l in obs_lines:
        action = l[l.find("(")+1:l.find(")")]
        split_actions = action.split(' ')
        
        # create a connection to the service
        get_functions_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/functions', GetAttributeService)
        functions = get_functions_service().attributes


        for func in functions:
            if func.attribute_name == "mission-length":
                mission_length = func.function_value
            
            elif func.attribute_name == "battery-amount":
                battery_amount = func.function_value

            elif func.attribute_name == "velocity":
                velocity = func.function_value
            
            elif func.attribute_name == "discharge-rate-battery":
                battery_discharge = func.function_value
            

            elif func.attribute_name == "battery-capacity":
                battery_capacity = func.function_value 
    
            elif func.attribute_name == "input-capacity":
                input_capacity = func.function_value

            elif func.attribute_name == "input-amount":
                input_amount = func.function_value



        if split_actions[0] == "go_to":
            start = split_actions[1]
            end = split_actions[2]
            
            for func in functions:
                if func.attribute_name == "distance" and func.values[0].value == start and func.values[1].value == end:
                    dist = func.function_value

            update_battery_amount(battery_amount, velocity, battery_discharge, value=dist)
            update_mission_length(mission_length, amount=dist)

        elif split_actions[0] == "take_image":
            update_battery_amount(battery_amount, velocity, battery_discharge, value=1000)
            update_mission_length(mission_length, amount=1000)

        elif split_actions[0] == "pulverize_region":
            update_battery_amount(battery_amount, velocity, battery_discharge, value=314)
            update_mission_length(mission_length, amount=314)
            update_input_amount(input_amount)

        elif split_actions[0] == "recharge_battery":
            recharge_battery(battery_capacity)

        elif split_actions[0] == "recharge_input":
            recharge_input(input_capacity)
            
            
### execute visit all ####
try:
    start = timer()

    # Saves the state of the current (initial) kb
    instances, propositions, functions, timed_knowledge, metrics = get_knowledge()

    # Loop through all the candidate goals and find the cost of all the plans generated from the initial state to each
    # of the candidate goals (lines 1-2 in pseudocode)
    with open(hyp, "r+") as f:
        # For each line in the dataset
        for line in f:
            Add = True
            # Add the candidate goals to the knowledge base by reading from the candidate goals file
            split_line = line.split(',')
            add_or_remove_goal(split_line, Add)

            # Find the plan for the candidate goals
            plan_found = generate_problem_and_plan()

            try:
                rospy.Subscriber("/rosplan_planner_interface/planner_output", String, callback)
                rospy.Subscriber("/kcl_rosplan/action_dispatch", String, callback_action)
                rospy.sleep(1)
            except rospy.ROSInterruptException:
                pass
            rospy.sleep(1)

            if plan_found:
               goals_ideal_plans[line] = plan
                # Find the cost of the plans and save them in the cost_plans array
               cost_plans.append(get_plan_cost(plan))
            else:
                goals_ideal_plans[line] = ""
                cost_plans.append(0.0)
            

            # Clear knowledge base after each candidate goals cost is found
            Add = False
            add_or_remove_goal(split_line, Add)

    f.close()

    # Go through the observations and compute the cost of the plans to reach the candidate goals after complying
    # with the observations. This cost is used to compute a score and probability to then rank the goals
    count_obs = 1
    cost_obs = 0


    # Number of observations
    with open(obs, "r+") as input_file:
        lines_num = len(input_file.readlines())
    input_file.close()

    # create a log file
    with open(log_file, "w") as log:
        log.write("@> Goal Mirroring Recognition Process \n \n")
    log.close()

    with open(log_file, "a") as log:
        with open(real_goal, "r+") as real:
            for line in real:
                log.write("#> Real Goal: (and " + line + " ) \n \n")
                true_goal = line
        real.close()
    log.close()

    with open(log_file, "a") as log:
        with open(hyp, "r+") as hypothesis_goals:
            for line in hypothesis_goals:
                log.write("\t # Goal: (and " + line.replace("\n\r", " ))") + "\n")
                log.write("\t # Ideal Plan: " + goals_ideal_plans[line].replace("\n", "\n\t") + "\n")
                log.write("\t # Ideal Plan Cost: " + str(get_plan_cost(goals_ideal_plans[line])) + "\n \n")
        hypothesis_goals.close()
    log.close()

    # Loop through each observation (Line 3 in pseudocode)
    for obs_num in range(1, lines_num+1):

        write_temp_obs(obs_num)
        cost_obs = 1 * obs_num
        suffix_plan_cost = []
        score_candidate_goals = []

        count_goals = 0
        goals_probability = dict()

        # Loop through the candidate goals (line 5 in pseudocode)
        with open(hyp, "r+") as candidate_goals:
            for line in candidate_goals:
                Add = True
                # Add the candidate goals to the knowledge base by reading from the candidate goals file
                split_line = line.split(',')
                add_or_remove_goal(split_line, Add)

                # Execute the plan so that it complies with the observations
                execute_plan()
                rospy.sleep(1)

                update_numeric_values_kb()

                # Find the plan for the candidate goals
                plan_found = generate_problem_and_plan()
                try:
                    rospy.Subscriber("/rosplan_planner_interface/planner_output", String, callback)
                    rospy.Subscriber("/kcl_rosplan/action_dispatch", String, callback_action)
                    rospy.sleep(1)
                except rospy.ROSInterruptException:
                    pass
                # rospy.sleep(1)

                suffix_plan_cost.append(get_plan_cost(plan))
                # Calculate the score for each goal (line 7 in pseudocode)
                score = cost_plans[count_goals] / (cost_obs + get_plan_cost(plan))
                score_candidate_goals.append(score)
                count_goals += 1


                if plan_found:
                    goals_o_plans[line].append(plan)
                elif(plan_already_solved_metric_ff()):
                    goals_o_plans[line].append("")                    
                else:
                    goals_o_plans[line].append("Plan not found!")


                clear_kb()
                reinitialise_kb(instances, propositions, functions, timed_knowledge, metrics)

        candidate_goals.close()


        with open(log_file, "a") as log:
            with open(temp_obs, "r+") as temp:
                last_line = temp.readlines()[-1]
                log.write("$> Observation (" + str(obs_num) + "): " + last_line + "\n \n")
            temp.close()
        log.close()

        score_possible_goals = []
        for key, value in goals_o_plans.items():
            # Sets score of plan to 0 if not found
            if "Plan not found!" in value[obs_num-1]:
                score = 0.0
            else:
                score = get_plan_cost(goals_ideal_plans[key]) / (cost_obs + get_plan_cost(value[obs_num-1]))
            score_possible_goals.append(score)

        # Calculate the probability of each goal
        prob_goal = []
        for line, goal_score in zip(goals_o_plans, score_possible_goals):
            if sum(score_possible_goals) != 0:
                n = 1/sum(score_possible_goals)
            else:
                n = 0
            prob_goal.append(n * goal_score)

            goals_probability[line] = n * goal_score

        end = timer()

        max_val = max(goals_probability.values())
        maxkeyarray = [key.strip() for key in goals_probability if goals_probability[key] == max_val]

        y_true = []
        y_pred = []
        for key in goals_o_plans:
            if key.strip() == true_goal.strip():
                y_true.append(1)
            else:
                y_true.append(0)

        # for key in goals_probability:
        for key in goals_o_plans:
            if key.strip() in maxkeyarray:
                y_pred.append(1)
            else:
                y_pred.append(0)

        TN, FP, FN, TP = confusion_matrix(y_true, y_pred, labels=[0, 1]).ravel()

        TPR = TP / float(TP + FN)
        FPR = FP / float(FP + TN)
        FNR = FN / float(FN + TP)
        F1_Score = float(2 * TP) / float((2 * TP) + FP + FN)

        with open(log_file, "a") as log:
            log.write("\tPredicted Goal: " + str(maxkeyarray))
            log.write("\n\tTP: " + str(TP))
            log.write("\n\tFP: " + str(FP))
            log.write("\n\tTN: " + str(TN))
            log.write("\n\tFN: " + str(FN) + "\n\n")

            log.write("\n\tTPR: " + str(TPR))
            log.write("\n\tFPR: " + str(FPR))
            log.write("\n\tFNR: " + str(FNR))
            log.write("\n\tF1 score: " + str(F1_Score) + "\n\n")
        log.close()


        with open(log_file, "a") as log:
            with open(hyp, "r+") as hypothesis_goals:
                for line in hypothesis_goals:
                    log.write("\t # Goal: (and " + line.replace("\n\r", " )) \n"))
                    log.write("\t # Plan complying with obs: " + goals_o_plans[line][obs_num-1].replace("\n", "\n\t") + "\n")
                    log.write("\t # Plan complying with obs Cost: " + str(get_plan_cost(goals_o_plans[line][obs_num-1])) + "\n")
                    log.write("\t @@@ Goal Probability: " + str(goals_probability[line]) + "\n \n")

            hypothesis_goals.close()
            log.write("\n Time of execution: " + str((end - start)) + " seconds\n")
        log.close()

        time_sec = end - start
        
        # Stop recognition process after 1 hour time limit
        if (time_sec/60) > 60:
            break



except rospy.ServiceException as e:
    rospy.logerr("KCL: (%s) Service call failed: %s" % (rospy.get_name(), e))
