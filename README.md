# ROSPlan-Project

This repository contains the code for the MSc Master's project for Goal Recognition in ROS using ROSPlan. It is organised as follows:

* Agricultural-Farm
  * This is a new dataset created by extending the Harpia domain Model [1]. It is a Numeric Planning domain model that is formalised in PDDL+. It contains 20 different recognition problems; 5 initial states are defined with 4 recognition problems for each initial state. Each recognition problem contains an observation (obs.dat), real goal (real_hyp.dat), candidate goals (hyps.dat) and the domain model.
* Harpia
  * This is the Harpia dataset. It contains 20 different recognition problems; 5 initial states are defined with 4 recognition problems for each initial state. Each recognition problem contains an observation (obs.dat), real goal (real_hyp.dat), candidate goals (hyps.dat) and the domain model.
* launch
  * These contain the launch files for the Goal Mirroring Approach (for both datasets) and Diverse Mirroring (for Harpia dataset
* scripts
  * These contain the python scripts for the Goal Mirroring Algorithms developed in ROSPlan: Goal Mirroring and Diverse Mirroring. 
    
 



1. Vannini, V., de Moura Souza, G. and Toledo, C.F.M., 2023. Harpia: A hybrid system for agricultural UAV missions. Smart Agricultural Technology, 4, p.100191.
