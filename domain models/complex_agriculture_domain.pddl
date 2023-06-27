(define (domain complex_agriculture_domain_harpia)


    (:requirements  :typing  :strips  :disjunctive-preconditions  :equality :numeric-fluents :negative-preconditions  )


    (:types
        region crop livestock food box produce - object
        base - region
        robot - agent
        aerial ground - robot
        ; crop-land box-location livestock-land food-station robot-location - location)
        position - location
        charging-station - position)

    (:functions

        ;; Variavel q controla bateria em porcentagem
        (battery-amount ?robot - robot)
        ;; quantidade de insumo
        (input-amount ?aerial - aerial)
        ;;velocidade de carregar a bateria em porcentagem por segundos
        (recharge-rate-battery)
        ;;velocidade de descarregar a bateria
        (discharge-rate-battery)
        ;;capacidade maxima bateria
        (battery-capacity)
        ;;capacidade maxima de insumo
        (input-capacity)
        ;;velocidade de reabastecer o insumo
        (recharge-rate-input)
        ;;distancia entre regioes em metros
        (distance ?from-region - region ?to-region - region)
        ;;velocidade em m/s
        (velocity ?robot - robot)
        (picture-path-len ?region - region)
        (pulverize-path-len ?region - region)
        (total-goals)
        (goals-achived)
        (mission-length)
        

        ; Determines the amound of food that livestock would require
        (food-amount ?ground - ground)
        ; The maximum capacity of food a robot can carry
        (food-capacity)
        ; Distance between locations
        (distance_location ?from - position ?to - position)
        
        ; Determines the amound of water that robot currently has
        (water-amount ?ground - ground)
        ; The maximum capacity of water a robot can carry
        (water-capacity)
    )


     (:predicates
    
        (been-at ?region - region)
        ;;se esta carregando um insumo
        (carry)  
        ;;esta em uma regiao
        (at ?robot - aerial ?region - region)
        ;; se pode pulverizar
        (can-spray)
        ;;se pode carregar/descarregar
        (can-recharge)
        ;se já tirou a foto
        (taken-image ?region - region)
        ;se pulverizou (spraying, the inputs are the different chemical agents for the spraying)
        (pulverized ?region - region)
        ; (canGo)
        (can-take-pic)
        (its-not-base ?region - region)
        (pulverize-goal ?region - region)
        (picture-goal ?region - region)
        (hw-ready ?from - region ?to - region)

        ; Is the land where the crop resides free
        (no-crop ?location - location)
        ; Determines if the crop on a particular land is ripe
        (crop-ripe ?crop - crop ?location - location)
        ; Determines if the box is at the initial location
        (box-at-initial-location ?location - location)
        ; Livestock is hungry and needs food
        (livestock-hungry ?livestock - livestock)
        ; The location of the livestock within the domain
        (object_at ?object - livestock ?location - position)
        ; The goal is to feed the livestock
        (feed-livestock-goal ?livestock - livestock)
        ; Agent location
        (robot_at ?ground - robot ?location - position)
        ; The goal that the livestock is fed
        (fed ?livestock - livestock)
        ; Hand is free to grab the crop
        (hand-free ?robot - ground)
        ; Hand is holding object
        (holding ?robot - ground ?crop - crop)
        ; The location of the crop within the domain
        (crop_at ?object - crop ?location - position)
        ; The goal that the box contains the crop 
        (contains ?box - box ?crop - crop)
        ; The goal of putting the harvested crop into the box
        (put-into-box-goal ?box - box ?crop - crop)
        ; The box is at the location
        (box_at ?box - box ?location - position)
        ; The goal of wattering the crop
        (crop-water-goal ?crop - crop)
        ; The goal that the crop is watered
        (wet ?crop - crop)
        ; The produce belongs to the livestock
        (belong_to ?produce - produce ?livestock - livestock)
        ; The robot is holding the produce
        (hold-produce ?robot - ground ?produce - produce)
        ; The goal of putting the produce in the box
        (put-produce-into-box-goal ?box - box ?produce - produce)
        ; The goal that the box contains the produce 
        (box-contains-produce ?box - box ?produce - produce)
        ; (can-go-to-base)
        ; (has-pulverize-goal)
        ; (has-picture-goal)
        ; (at-move)
    
    )


    (:action feed_livestock
        :parameters (
            ?livestock - livestock
            ; ?food - food
            ?location - position
            ?robot - ground
        )
        :precondition (and 
            (livestock-hungry ?livestock)
            (robot_at ?robot ?location)
            (object_at ?livestock ?location)
            (> (food-amount ?robot) 0)
            (feed-livestock-goal ?livestock)
            (> (battery-amount ?robot) 
                (*
                    (/
                        250
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )

        )
        :effect (and 
            (fed ?livestock)
            (increase (mission-length) 250)
            (decrease (food-amount ?robot) 1)
            (not (livestock-hungry ?livestock))
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        250
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )
    

    (:action gather_produce
        :parameters (
            ?livestock-location - position
            ?robot - ground
            ?livestock - livestock
            ?produce - produce)
        :precondition (and
            (robot_at ?robot ?livestock-location)
            (object_at ?livestock ?livestock-location)
            (hand-free ?robot)
            (belong_to ?produce ?livestock)
            (> (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
        :effect 
        (and
            (not (hand-free ?robot))
            (not (belong_to ?produce ?livestock))
            (hold-produce ?robot ?produce)
            (increase (mission-length) 20)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )


     (:action harvest_crop
        :parameters (
            ?crop-location - position
            ?robot - ground
            ?crop - crop)
        :precondition (and
            (robot_at ?robot ?crop-location)
            (crop_at ?crop ?crop-location)
            (crop-ripe ?crop ?crop-location)
            (hand-free ?robot)
            (> (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
        :effect 
        (and
            (not (hand-free ?robot))
            (not (crop_at ?crop ?crop-location))
            (holding ?robot ?crop)
            (increase (mission-length) 20)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )

    (:action water_crop
        :parameters (
            ?crop-location - position
            ?robot - ground
            ?crop - crop)
        :precondition (and
            ; (robot_at ?robot ?food-station)
            (robot_at ?robot ?crop-location)
            (crop_at ?crop ?crop-location)
            (> (water-amount ?robot) 0)
            (crop-water-goal ?crop)
            (> (battery-amount ?robot) 
                (*
                    (/
                        500
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
        :effect 
        (and
            (wet ?crop)
            (increase (mission-length) 100)
            (decrease (water-amount ?robot) 1)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        500
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )


    (:action recharge_battery_ground
        :parameters (?robot - ground
        ?battery_recharging_Station - charging-station)
        :precondition (and
            (robot_at ?robot ?battery_recharging_Station)
        )
        :effect 
        (and
            (assign (battery-amount ?robot) (battery-capacity))
        )
    )

    (:action drop_crop_in_box
        :parameters (
            ?crop - crop
            ?robot - ground
            ?box-location - position
            ?box - box)
        :precondition (and
            (robot_at ?robot ?box-location)
            (holding ?robot ?crop)
            (put-into-box-goal ?box ?crop)
            (box_at ?box ?box-location)
            (> (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
        :effect 
        (and
            (not (holding ?robot ?crop))
            (hand-free ?robot)
            (contains ?box ?crop)
            (increase (mission-length) 20)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )


    (:action drop_produce_in_box
        :parameters (
            ?produce - produce
            ?robot - ground
            ?box-location - position
            ?box - box)
        :precondition (and
            (robot_at ?robot ?box-location)
            (hold-produce ?robot ?produce)
            (put-produce-into-box-goal ?box ?produce)
            (box_at ?box ?box-location)
            (> (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
        :effect 
        (and
            (not (hold-produce ?robot ?produce))
            (hand-free ?robot)
            (box-contains-produce ?box ?produce)
            (increase (mission-length) 20)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        100
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )


    ; Recharge the food amount to feed the livestock if food amount is less than half of food capacity
    (:action recharge_food_amount
        :parameters (
            ?food-station - charging-station
            ?robot - ground)
        :precondition (and
            (robot_at ?robot ?food-station)
            ; (< (food-amount) (/ (2) (food-capacity)))
        )
        :effect 
        (and
            (assign (food-amount ?robot) (food-capacity))
        )
    )


    (:action recharge_water_amount
        :parameters (
            ?water-station - charging-station
            ?robot - ground)
        :precondition (and
            (robot_at ?robot ?water-station)
            ; (< (food-amount) (/ (2) (food-capacity)))
        )
        :effect 
        (and
            (assign (water-amount ?robot) (water-capacity))
        )
    )

    (:action move_robot
        :parameters (
             ?from - position 
             ?to - position
             ?robot - ground)
        :precondition (and
            (robot_at ?robot ?from)
            (> (battery-amount ?robot) (+ (* (/ (distance_location ?from ?to) (velocity ?robot)) (discharge-rate-battery)) 20))
        )
        :effect (and 
                (not (robot_at ?robot ?from))
                ; (been-at ?to)
                (robot_at ?robot ?to)
                (decrease (battery-amount ?robot) 
                      (*
                          (/
                              (distance_location ?from ?to)
                              (velocity ?robot)
                          )
                          (discharge-rate-battery)
                      )
          
                )
                (increase (mission-length) (distance_location ?from ?to))
        )
    )


    (:action go_to
        :parameters (
             ?from-region - region 
             ?to-region - region
             ?robot - aerial)
        :precondition (and
            (at ?robot ?from-region)
            (> (battery-amount ?robot) (+ (* (/ (distance ?from-region ?to-region) (velocity ?robot)) (discharge-rate-battery)) 15))
        )
        :effect (and 
                (not (at ?robot ?from-region))
                (been-at ?to-region)
                (at ?robot ?to-region)
                (decrease (battery-amount ?robot) 
                      (*
                          (/
                              (distance ?from-region ?to-region)
                              (velocity ?robot)
                          )
                          (discharge-rate-battery)
                      )
          
                )
                (increase (mission-length) (distance ?from-region ?to-region))
                )
    )
    
    (:action take_image
        :parameters (
            ?region - region
            ?robot - aerial
        )
        :precondition(and
            (at ?robot ?region)
            (picture-goal ?region)
            (> (battery-amount ?robot) 
                (*
                    (/
                        1000
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
       )
        :effect(and
            (taken-image ?region)
            (increase (mission-length) 1000)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        1000
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )

    (:action pulverize_region
        :parameters (
            ?region - region
            ?robot - aerial)
        :precondition(and
            (at ?robot ?region)
            (pulverize-goal ?region)
            (> (input-amount ?robot) 0)
            (> (battery-amount ?robot) 
                (*
                    (/
                        314
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
       )
        :effect(and
            (pulverized ?region)
            (increase (mission-length) 314)
            (decrease (input-amount ?robot) 1)
            (decrease (battery-amount ?robot) 
                (*
                    (/
                        314
                        (velocity ?robot)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )

    (:action recharge_battery
        :parameters (
            ?base - base
            ?robot - aerial
            )
        :precondition (and
            (at ?robot ?base)
            ;(< (battery-amount) 60)
        )
        :effect 
        (and
            (assign (battery-amount ?robot) (battery-capacity))
        )
    )


    (:action recharge_input
        :parameters (
            ?base - base
            ?robot - aerial)
        :precondition (and
            (at ?robot ?base)
            (< (input-amount ?robot) (/ (input-capacity) 2))
        )
        :effect 
        (and
            (assign (input-amount ?robot) (input-capacity))
        )
    )

)
