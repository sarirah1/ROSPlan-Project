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

    (= (battery-amount) 20)

    (= (input-amount) 2)

    (= (discharge-rate-battery) 0.1)

    (= (battery-capacity) 45)

    (= (input-capacity) 2)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 564.256)
    (= (distance region_2 region_1) 564.256)

    (= (distance region_1 region_5) 432.472)
    (= (distance region_5 region_1) 432.472)

    (= (distance region_1 region_6) 624.674)
    (= (distance region_6 region_1) 624.674)

    ; Region 2 distance with other regions
    (= (distance region_2 region_5) 532.346)
    (= (distance region_5 region_2) 532.346)

    (= (distance region_2 region_6) 342.241)
    (= (distance region_6 region_2) 342.241)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 783.631)
    (= (distance region_6 region_5) 783.631)

    ; Region 2 with bases
    (= (distance base_1 region_2) 753.421)
    (= (distance region_2 base_1) 753.421)

    (= (distance base_2 region_2) 234.572)
    (= (distance region_2 base_2) 234.572)

    (= (distance base_3 region_2) 596.532)
    (= (distance region_2 base_3) 596.532)

    ; Region 1 with bases
    (= (distance base_1 region_1) 936.211)
    (= (distance region_1 base_1) 936.211)

    (= (distance base_2 region_1) 564.245)
    (= (distance region_1 base_2) 564.245)

    (= (distance base_3 region_1) 875.534)
    (= (distance region_1 base_3) 875.534)

    ; Region 5 with bases
    (= (distance base_1 region_5) 675.242)
    (= (distance region_5 base_1) 675.242)

    (= (distance base_2 region_5) 765.234)
    (= (distance region_5 base_2) 765.234)

    (= (distance base_3 region_5) 43.764)
    (= (distance region_5 base_3) 43.764)

    ; Region 6 with bases
    (= (distance base_1 region_6) 454.525)
    (= (distance region_6 base_1) 454.525)

    (= (distance base_2 region_6) 677.424)
    (= (distance region_6 base_2) 677.424)

    (= (distance base_3 region_6) 123.543)
    (= (distance region_6 base_3) 123.543)

    ; Base distance with one another
    (= (distance base_1 base_2) 566.234)
    (= (distance base_2 base_1) 566.234)

    (= (distance base_1 base_3) 903.562)
    (= (distance base_3 base_1) 903.562)

    (= (distance base_2 base_3) 34.432)
    (= (distance base_3 base_2) 34.432)


    (= (velocity) 4.2)


    (= (mission-length) 0)

)
(:goal (and
    (taken-image region_5)
    (taken-image region_6)
    (taken-image region_1)
    (taken-image region_2)
))
(:metric minimize (mission-length))
)
