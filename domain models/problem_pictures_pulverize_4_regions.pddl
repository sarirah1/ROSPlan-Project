(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base
)
(:init
    (at base_1)

    (picture-goal region_5)
    (picture-goal region_6)
    (picture-goal region_1)
    (picture-goal region_2)
    (pulverize-goal region_1)
    (pulverize-goal region_6)

    (= (battery-amount) 20)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.0853)

    (= (battery-capacity) 45)

    (= (input-capacity) 1)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 134.536)
    (= (distance region_2 region_1) 134.536)

    (= (distance region_1 region_5) 245.432)
    (= (distance region_5 region_1) 245.432)

    (= (distance region_1 region_6) 65.242)
    (= (distance region_6 region_1) 65.242)

    ; Region 2 distance with other regions
    (= (distance region_2 region_5) 753.534)
    (= (distance region_5 region_2) 753.534)

    (= (distance region_2 region_6) 642.234)
    (= (distance region_6 region_2) 642.234)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 146.644)
    (= (distance region_6 region_5) 146.644)

    ; Region 2 with bases
    (= (distance base_1 region_2) 333.532)
    (= (distance region_2 base_1) 333.532)

    (= (distance base_2 region_2) 965.467)
    (= (distance region_2 base_2) 965.467)

    (= (distance base_3 region_2) 643.752)
    (= (distance region_2 base_3) 643.752)

    ; Region 1 with bases
    (= (distance base_1 region_1) 21.553)
    (= (distance region_1 base_1) 21.553)

    (= (distance base_2 region_1) 75.245)
    (= (distance region_1 base_2) 75.245)

    (= (distance base_3 region_1) 743.424)
    (= (distance region_1 base_3) 743.424)

    ; Region 5 with bases
    (= (distance base_1 region_5) 447.753)
    (= (distance region_5 base_1) 447.753)

    (= (distance base_2 region_5) 765.987)
    (= (distance region_5 base_2) 765.987)

    (= (distance base_3 region_5) 884.432)
    (= (distance region_5 base_3) 884.432)

    ; Region 6 with bases
    (= (distance base_1 region_6) 456.754)
    (= (distance region_6 base_1) 456.754)

    (= (distance base_2 region_6) 564.867)
    (= (distance region_6 base_2) 564.867)

    (= (distance base_3 region_6) 852.342)
    (= (distance region_6 base_3) 852.342)

    ; Base distance with one another
    (= (distance base_1 base_2) 243.535)
    (= (distance base_2 base_1) 243.535)

    (= (distance base_1 base_3) 45.534)
    (= (distance base_3 base_1) 45.534)

    (= (distance base_2 base_3) 34.432)
    (= (distance base_3 base_2) 34.432)


    (= (velocity) 6.55)


    (= (mission-length) 0)

)
(:goal (and
    (taken-image region_5)
    (taken-image region_6)
    (taken-image region_1)
    (taken-image region_2)
    (pulverized region_1)
    (pulverized region_6)

))
(:metric minimize (mission-length))
)
