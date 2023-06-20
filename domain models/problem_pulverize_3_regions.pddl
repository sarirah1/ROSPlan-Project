(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base
)
(:init
    (at base_1)

    (pulverize-goal region_2)
    (pulverize-goal region_1)
    (pulverize-goal region_3)

    (= (battery-amount) 10)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.062)

    (= (battery-capacity) 30)

    (= (input-capacity) 2)

    ; Regions distance between each others
    (= (distance region_1 region_2) 252.934)
    (= (distance region_2 region_1) 252.934)

    (= (distance region_1 region_3) 764.934)
    (= (distance region_3 region_1) 764.934)

    (= (distance region_2 region_3) 963.934)
    (= (distance region_3 region_2) 963.934)

    ; Region 2 with bases
    (= (distance base_1 region_2) 428.039)
    (= (distance region_2 base_1) 428.039)

    (= (distance base_2 region_2) 679.629)
    (= (distance region_2 base_2) 679.629)

    (= (distance base_3 region_2) 972.901)
    (= (distance region_2 base_3) 972.901)

    ; Region 1 with bases
    (= (distance base_1 region_1) 146.573)
    (= (distance region_1 base_1) 146.573)

    (= (distance base_2 region_1) 756.481)
    (= (distance region_1 base_2) 756.481)

    (= (distance base_3 region_1) 247.646)
    (= (distance region_1 base_3) 247.646)

    ; ; Region 3 with bases
    (= (distance base_1 region_3) 674.573)
    (= (distance region_3 base_1) 674.573)

    (= (distance base_2 region_3) 447.481)
    (= (distance region_3 base_2) 447.481)

    (= (distance base_3 region_3) 579.646)
    (= (distance region_3 base_3) 579.646)

    ; Base distance with one another
    (= (distance base_1 base_2) 842.942)
    (= (distance base_2 base_1) 842.942)

    (= (distance base_1 base_3) 246.2343)
    (= (distance base_3 base_1) 246.2343)

    (= (distance base_2 base_3) 632.892)
    (= (distance base_3 base_2) 632.892)


    (= (velocity) 3.1)


    (= (mission-length) 0)

)
(:goal (and
    (pulverized region_1)
    (pulverized region_2)
    (pulverized region_3)
))
(:metric minimize (mission-length))
)