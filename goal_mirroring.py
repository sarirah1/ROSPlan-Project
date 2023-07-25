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
# from rosplan_interface_mapping.srv import CreatePRM
from rosplan_dispatch_msgs.srv import DispatchService, DispatchServiceResponse, PlanningService, PlanningServiceResponse, ParsingService
from diagnostic_msgs.msg import KeyValue
from rosplan_knowledge_msgs.msg import KnowledgeItem
from rosplan_dispatch_msgs.msg import ActionDispatch

############
# THE REST #
############

# get path of pkg
rospack = rospkg.RosPack()
rospy.init_node("coordinator")

# load parameters
# max_prm_size = rospy.get_param('~max_prm_size', 1000)
planner_command = rospy.get_param('~planner_command', "")
domain_path = rospy.get_param('~domain_path', "")
problem_path = rospy.get_param('~problem_path', "")
data_path = rospy.get_param('~data_path', "")
hyp = rospy.get_param('~hypothesis_goals', "")
obs = rospy.get_param('~observations', "")
temp_obs = rospy.get_param('~temp_observations', "")
initial_state = rospy.get_param('~initial_state', "")

# wait for services
# rospy.wait_for_service('/rosplan_roadmap_server/create_prm')
rospy.wait_for_service('/rosplan_problem_interface/problem_generation_server')
rospy.wait_for_service('/rosplan_planner_interface/planning_server_params')
rospy.wait_for_service('/rosplan_plan_dispatcher/dispatch_plan')
rospy.wait_for_service('/rosplan_parsing_interface/parse_plan')


plan = ""
cost_plans = []

def get_object_type(string):
    objects = ["region", "crop", "livestock", "produce", "box", "location", "robot"]
    for obj in objects:
        if obj in string:
            return str(obj)


def callback(data):
    # rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.data)
    global plan
    plan = data.data
    # print(type(data.data))


def callback_action(data):
    print("DISPATCH THE FREAKING PLAN OMG")
    print(data.data)


# Get the total cost of each plan
def get_plan_cost(plan):
    action_list = plan.splitlines()
    cost = 0.0
    # get plan duration
    # t1 = action_list[len(action_list)-1].split(":")[0]
    if len(action_list ==0):
        return cost
    # The cost of each action
    t2 = float(action_list[len(action_list)-1].split("[")[1].split("]")[0])
    # Add the cost of each action
    for action in action_list:
        cost = cost + t2

    return round(cost, 3)


# Dispatch the action
def dispatch_action():
    # Create a publisher
    pub = rospy.Publisher('/kcl_rosplan/action_dispatch', ActionDispatch, queue_size=10)

    # Allow some time for the publisher to connect to subscribers
    rospy.sleep(1.0)

    # Create the ActionDispatch message
    msg = ActionDispatch()

    value = "robot_initial_location"
    key = "location"
    value1 = "box_1_location"
    key1 = get_object_type(value1)
    value2 = "robot_1"
    key2 = get_object_type(value2)

    msg.name = 'move_robot'
    msg.parameters = [
        KeyValue(key, value),
        KeyValue(key1, value1),
        KeyValue(key2, value2)
    ]
    msg.dispatch_time = rospy.Time.now()

    # Publish the message
    pub.publish(msg)

    # Allow some time for the message to be sent
    rospy.sleep(1.0)


def add_or_remove_goal(split_line, Add):
    for action in split_line:
        # The goal name
        kus = KnowledgeUpdateServiceRequest()
        if Add:
            kus.update_type = 1
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
            if '\n' in action.split(' ')[2][:-3]:
                kv.value = action.split(' ')[1][:-3]
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


def get_knowledge():
    rospy.wait_for_service('/rosplan_knowledge_base/state/instances')
    rospy.wait_for_service('/rosplan_knowledge_base/state/propositions')
    rospy.wait_for_service('/rosplan_knowledge_base/state/functions')
    rospy.wait_for_service('/rosplan_knowledge_base/state/timed_knowledge')
    rospy.wait_for_service('/rosplan_knowledge_base/state/metric')
    try:
        # get instances
        get_instances_service = rospy.ServiceProxy('/rosplan_knowledge_base/state/instances', GetInstanceService)
        # instances = get_instances_service().instances
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
                # print(instance)
                # print(instance_type)
                # print(f"Instance: {instance}, Type: {instance_type}")


        # print(instances)
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
        # update_type_array = [4]
        # for i in range(len(metrics)):
        #     update_type_array.append(4)
        # print(metrics)
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
    # rospy.wait_for_service('/rosplan_parsing_interface/parse_problem')
    # try:
    #     parse_problem_service = rospy.ServiceProxy('/rosplan_parsing_interface/parse_problem', Empty)
    #     resp1 = parse_problem_service()
    # except rospy.ServiceException as e:
    #     print("Service call failed: %s" % e)
    # rospy.wait_for_service('/rosplan_knowledge_base/domain/path')
    # try:
    #     load_problem_service = rospy.ServiceProxy('/rosplan_knowledge_base/domain/path', String)
    #     response = load_problem_service(initial_state)
    #     if response.success:
    #         print("Problem file loaded successfully")
    #     else:
    #         print("Failed to load problem file")
    # except rospy.ServiceException as e:
    #     print("Service call failed: %s" % e)


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

# def execute_plan():
#
#     rospy.loginfo("KCL: (%s) Calling plan parser" % rospy.get_name())
#     pp = rospy.ServiceProxy('/rosplan_parsing_interface/parse_plan', Empty)
#     if not pp():
#         rospy.logerr("KCL: (%s) The plan was not parsed!" % rospy.get_name())
#         return
#
#     rospy.sleep(3)
#
#     rospy.loginfo("KCL: (%s) Calling plan execution" % rospy.get_name())
#     pd = rospy.ServiceProxy('/rosplan_plan_dispatcher/dispatch_plan', DispatchService)
#
#     # Create a publisher
#     pub = rospy.Publisher('/kcl_rosplan/action_dispatch', ActionDispatch, queue_size=10)
#
#     # Allow some time for the publisher to connect to subscribers
#     rospy.sleep(1.0)
#
#     # Create the ActionDispatch message
#     msg = ActionDispatch()
#
#     value = "robot_initial_location"
#     key = "location"
#     value1 = "box_1_location"
#     key1 = get_object_type(value1)
#     value2 = "robot_1"
#     key2 = get_object_type(value2)
#
#     msg.name = 'move_robot'
#     msg.parameters = [
#         KeyValue(key, value),
#         KeyValue(key1, value1),
#         KeyValue(key2, value2)
#     ]
#     msg.dispatch_time = rospy.Time.now()
#
#     # Publish the message
#     pub.publish(msg)
#
#     # Allow some time for the message to be sent
#     rospy.sleep(1.0)
#
#
#     pd_response = pd()
#
#     if not pd_response:
#         rospy.logerr("KCL: (%s) No response from the dispatch server." % rospy.get_name())
#         return False
#     if not pd_response.goal_achieved:
#         rospy.loginfo("KCL: (%s) The execution was not successful." % rospy.get_name())
#         return False
#     else:
#         rospy.loginfo("KCL: (%s) Plan was executed." % rospy.get_name())
#         return True

def execute_plan():
    rospy.sleep(25.0)
    rospy.loginfo("KCL: (%s) Calling plan parser" % rospy.get_name())
    rospy.wait_for_service('/rosplan_parsing_interface/parse_plan_from_file')

    try:
        parse_plan_service = rospy.ServiceProxy('/rosplan_parsing_interface/parse_plan_from_file', ParsingService)

        # obs = "/mnt/c/Users/Public/ROSPlan/src/rosplan/rosplan_project/dataset_agriculture/p0/5_goals/test.dat"

        response = parse_plan_service(temp_obs)

        rospy.sleep(3)

        dispatch_plan_service = rospy.ServiceProxy('/rosplan_plan_dispatcher/dispatch_plan', DispatchService)
        pd_response = dispatch_plan_service()
        if not pd_response:
            rospy.logerr("KCL: (%s) No response from the dispatch server." % rospy.get_name())
            return False
        # if not pd_response.goal_achieved:
        #     rospy.loginfo("KCL: (%s) The execution was not successful." % rospy.get_name())
        #     return False
        else:
            rospy.loginfo("KCL: (%s) Plan was executed." % rospy.get_name())
            return True

    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)

def write_temp_obs(count_obs):
    with open(obs, "r+") as input_file:
        with open(temp_obs, "w") as output_file:
            for i, line in enumerate(input_file):
                if i < count_obs:
                    # The cost of the observations
                    cost_obs = 0.001 * count_obs
                    # Create a temporary file with the added observations to parse the file
                    output_file.write(line)
        output_file.close()
    input_file.close()


### execute visit all ####
try:
    rospy.sleep(3)

    # wait for odom to publish to sensing interface
    sps = rospy.ServiceProxy('/rosplan_knowledge_base/state/propositions', GetAttributeService)
    count = 0
    while count<1:
        rospy.sleep(1)
        gas = GetAttributeServiceRequest()
        gas.predicate_name = 'robot_at'
        facts = sps(gas)
        if not facts:
            rospy.logwarn("KCL: (%s) Proposition service not available." % rospy.get_name())
        count = 0
        for k in facts.attributes:
            if not k.is_negative:
                count = count + 1


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
            # if plan_found:
            #     execute_plan()
            #     print("DISPATCHED THE PLANNNNNNNNNNNN")
            try:
                rospy.Subscriber("/rosplan_planner_interface/planner_output", String, callback)
                rospy.Subscriber("/kcl_rosplan/action_dispatch", String, callback_action)
                rospy.sleep(1)
            except rospy.ROSInterruptException:
                pass
            rospy.sleep(1)

            # Find the cost of the plans and save them in the cost_plans array
            cost_plans.append(get_plan_cost(plan))
            print(plan)

            # Clear knowledge base after each candidate goals cost is found
            Add = False
            add_or_remove_goal(split_line, Add)

    f.close()
    print(cost_plans)

    # Go through the observations and compute the cost of the plans to reach the candidate goals after complying
    # with the observations. This cost is used to compute a score and probability to then rank the goals
    count_obs = 1
    cost_obs = 0

    # Saves the state of the current (initial) kb
    instances, propositions, functions, timed_knowledge, metrics = get_knowledge()

    # Number of observations
    with open(obs, "r+") as input_file:
        lines_num = len(input_file.readlines())
    input_file.close()
    # Loop through each observation (Line 3 in pseudocode)
    for obs_num in range(1, lines_num+1):
        write_temp_obs(obs_num)
        cost_obs = 0.001 * obs_num
        print("NKFNRSFKLSNFKLSNG", obs_num)
        suffix_plan_cost = []
        score_candidate_goals = []
        count_goals = 0
        # Loop through the candidate goals (line 5 in pseudocode)
        with open(hyp, "r+") as candidate_goals:
            for line in candidate_goals:
                Add = True
                # Add the candidate goals to the knowledge base by reading from the candidate goals file
                split_line = line.split(',')
                add_or_remove_goal(split_line, Add)

                # Execute the plan so that it complies with the observations
                execute_plan()
                # Find the plan for the candidate goals
                plan_found = generate_problem_and_plan()
                try:
                    rospy.Subscriber("/rosplan_planner_interface/planner_output", String, callback)
                    rospy.Subscriber("/kcl_rosplan/action_dispatch", String, callback_action)
                    rospy.sleep(1)
                except rospy.ROSInterruptException:
                    pass
                rospy.sleep(1)

                print(plan)
                suffix_plan_cost.append(get_plan_cost(plan))
                # Calculate the score for each goal (line 7 in pseudocode)
                score = cost_plans[count_goals] / (cost_obs + get_plan_cost(plan))
                score_candidate_goals.append(score)
                count_goals += 1

                print("suffix", suffix_plan_cost)
                print("score candidate goals", score_candidate_goals)
                # print(instances)
                # print(propositions)
                # print(functions)
                # print(timed_knowledge)
                # print(metrics)
                clear_kb()
                reinitialise_kb(instances, propositions, functions, timed_knowledge, metrics)
                # break
                # break
        candidate_goals.close()

        # Calculate the probability of each goal
        prob_goal = []
        for goal_score in score_candidate_goals:
            n = 1/sum(score_candidate_goals)
            prob_goal.append(n * goal_score)

        print("GOAL PROB", prob_goal)
        # break

    # with open(obs, "r+") as input_file:
    #     with open(temp_obs, "w") as output_file:
    #         for i, line in enumerate(input_file):
    #             if i < count_obs:
    #                 # The cost of the observations
    #                 cost_obs = 0.001 * count_obs
    #                 # Create a temporary file with the added observations to parse the file
    #                 output_file.write(line)

                #     with open(hyp, "r+") as candidate_goals:
                #         for line in candidate_goals:
                #             Add = True
                #             # Add the candidate goals to the knowledge base by reading from the candidate goals file
                #             split_line = line.split(',')
                #             add_or_remove_goal(split_line, Add)
                #
                #             # Execute the plan so that it complies with the observations
                #             execute_plan()
                #             # Find the plan for the candidate goals
                #             plan_found = generate_problem_and_plan()
                #             try:
                #                 rospy.Subscriber("/rosplan_planner_interface/planner_output", String, callback)
                #                 rospy.Subscriber("/kcl_rosplan/action_dispatch", String, callback_action)
                #                 rospy.sleep(1)
                #             except rospy.ROSInterruptException:
                #                 pass
                #             rospy.sleep(1)
                #
                #             print(plan)
                #             suffix_plan_cost.append(get_plan_cost(plan))
                #             print(suffix_plan_cost)
                #             break
                #     candidate_goals.close()
                # else:
                #     count_obs += 1
                #     break




except rospy.ServiceException as e:
    rospy.logerr("KCL: (%s) Service call failed: %s" % (rospy.get_name(), e))
