(define (domain complex_agriculture_domain_harpia)


    (:requirements  :typing  :strips  :disjunctive-preconditions  :equality :numeric-fluents :negative-preconditions  )


    (:types
        region crop livestock food box - object
        base - region
        robot - agent
        ; crop-land box-location livestock-land food-station robot-location - location)
        position - location
        charging-station - position)

    (:functions

        ;; Variavel q controla bateria em porcentagem
        (battery-amount)
        ;; quantidade de insumo
        (input-amount)
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
        (velocity)
        (picture-path-len ?region - region)
        (pulverize-path-len ?region - region)
        (total-goals)
        (goals-achived)
        (mission-length)
        

        ; Determines the amound of food that lvestock would require
        (food-amount)
        ; The maximum capacity of food a robot can carry
        (food-capacity)
        ; Distance between locations
        (distance_location ?from - position ?to - position)

    )


     (:predicates
    
        (been-at ?region - region)
        ;;se esta carregando um insumo
        (carry)  
        ;;esta em uma regiao
        (at ?region - region)
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
        (robot_at ?robot - robot ?location - position)
        ; The goal that the livestock is fed
        (fed ?livestock - livestock)
        ; Hand is free to grab the crop
        (hand-free ?robot - robot)
        ; Hand is holding object
        (holding ?robot - robot ?crop - crop)
        ; The location of the crop within the domain
        (crop_at ?object - crop ?location - position)
        ; The goal that the box contains the crop 
        (contains ?box - box ?crop - crop)
        ; The goal of putting the harvested crop into the box
        (put-into-box-goal ?box - box ?crop - crop)
        ; The box is at the location
        (box_at ?box - box ?location - position)
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
            ?robot - robot
        )
        :precondition (and 
            (livestock-hungry ?livestock)
            (robot_at ?robot ?location)
            (object_at ?livestock ?location)
            (> (food-amount) 0)
            (feed-livestock-goal ?livestock)
            (> (battery-amount) 
                (*
                    (/
                        250
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )

        )
        :effect (and 
            (fed ?livestock)
            (increase (mission-length) 250)
            (decrease (food-amount) 1)
            (not (livestock-hungry ?livestock))
            (decrease (battery-amount) 
                (*
                    (/
                        250
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )
    

     (:action harvest_crop
        :parameters (
            ?crop-location - position
            ?robot - robot
            ?crop - crop)
        :precondition (and
            ; (robot_at ?robot ?food-station)
            (robot_at ?robot ?crop-location)
            (crop_at ?crop ?crop-location)
            ; (not (no-crop ?crop-location))
            (crop-ripe ?crop ?crop-location)
            (hand-free ?robot)
            ; (< (food-amount) (/ (2) (food-capacity)))
        )
        :effect 
        (and
            (not (hand-free ?robot))
            (not (crop_at ?crop ?crop-location))
            (holding ?robot ?crop)
            (increase (mission-length) 20)

        )
    )


    (:action recharge_battery_ground
        :parameters (?robot - robot
        ?battery_recharging_Station - charging-station)
        :precondition (and
            (robot_at ?robot ?battery_recharging_Station)
        )
        :effect 
        (and
            (assign (battery-amount) (battery-capacity))
        )
    )

    (:action drop_crop_in_box
        :parameters (
            ?crop - crop
            ?robot - robot
            ?box-location - position
            ?box - box)
        :precondition (and
            (robot_at ?robot ?box-location)
            (holding ?robot ?crop)
            (put-into-box-goal ?box ?crop)
            (box_at ?box ?box-location)
        )
        :effect 
        (and
            (not (holding ?robot ?crop))
            (hand-free ?robot)
            (contains ?box ?crop)
            (increase (mission-length) 20)

        )
    )


    ; Recharge the food amount to feed the livestock if food amount is less than half of food capacity
    (:action recharge_food_amount
        :parameters (
            ?food-station - position
            ?robot - robot)
        :precondition (and
            (robot_at ?robot ?food-station)
            ; (< (food-amount) (/ (2) (food-capacity)))
        )
        :effect 
        (and
            (assign (food-amount) (food-capacity))
        )
    )



    (:action move_robot
        :parameters (
             ?from - position 
             ?to - position
             ?robot - robot)
        :precondition (and
            (robot_at ?robot ?from)
            (> (battery-amount) (+ (* (/ (distance_location ?from ?to) (velocity)) (discharge-rate-battery)) 20))
        )
        :effect (and 
                (not (robot_at ?robot ?from))
                ; (been-at ?to)
                (robot_at ?robot ?to)
                (decrease (battery-amount ) 
                      (*
                          (/
                              (distance_location ?from ?to)
                              (velocity)
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
             ?to-region - region)
        :precondition (and
            (at ?from-region)
            (> (battery-amount) (+ (* (/ (distance ?from-region ?to-region) (velocity)) (discharge-rate-battery)) 15))
        )
        :effect (and 
                (not (at ?from-region))
                (been-at ?to-region)
                (at ?to-region)
                (decrease (battery-amount ) 
                      (*
                          (/
                              (distance ?from-region ?to-region)
                              (velocity)
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
        )
        :precondition(and
            (at ?region)
            (picture-goal ?region)
            (> (battery-amount) 
                (*
                    (/
                        1000
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )
       )
        :effect(and
            (taken-image ?region)
            (increase (mission-length) 1000)
            (decrease (battery-amount) 
                (*
                    (/
                        1000
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )

    (:action pulverize_region
        :parameters (
            ?region - region)
        :precondition(and
            (at ?region)
            (pulverize-goal ?region)
            (> (input-amount) 0)
            (> (battery-amount) 
                (*
                    (/
                        314
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )
       )
        :effect(and
            (pulverized ?region)
            (increase (mission-length) 314)
            (decrease (input-amount) 1)
            (decrease (battery-amount) 
                (*
                    (/
                        314
                        (velocity)
                    )
                    (discharge-rate-battery)
                )
            )
        )
    )

    (:action recharge_battery
        :parameters (?base - base)
        :precondition (and
            (at ?base)
            ;(< (battery-amount) 60)
        )
        :effect 
        (and
            (assign (battery-amount) (battery-capacity))
        )
    )


    (:action recharge_input
        :parameters (?base - base)
        :precondition (and
            (at ?base)
            (< (input-amount) (/ (input-capacity) 2))
        )
        :effect 
        (and
            (assign (input-amount) (input-capacity))
        )
    )

)
