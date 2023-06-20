(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base
)
(:init
    (at base_1)

    (picture-goal region_1)
    (picture-goal region_4)
    (picture-goal region_6)
    (pulverize-goal region_1)
    (pulverize-goal region_5)
    (pulverize-goal region_2)
    (pulverize-goal region_4)

    (= (battery-amount) 10)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.0663)

    (= (battery-capacity) 38)

    (= (input-capacity) 1)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 54.855)
    (= (distance region_2 region_1) 54.855)

    (= (distance region_1 region_4) 242.654)
    (= (distance region_4 region_1) 242.654)

    (= (distance region_1 region_5) 56.645)
    (= (distance region_5 region_1) 56.645)

    (= (distance region_1 region_6) 43.53)
    (= (distance region_6 region_1) 43.53)

    ; Region 2 distance with other regions
    (= (distance region_2 region_4) 85.866)
    (= (distance region_4 region_2) 85.866)

    (= (distance region_2 region_5) 755.477)
    (= (distance region_5 region_2) 755.477)

    (= (distance region_2 region_6) 34.423)
    (= (distance region_6 region_2) 34.423)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 566.969)
    (= (distance region_5 region_4) 566.969)

    (= (distance region_4 region_6) 23.432)
    (= (distance region_6 region_4) 23.432)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 432.534)
    (= (distance region_6 region_5) 432.534)

    ; Region 2 with bases
    (= (distance base_1 region_2) 842.424)
    (= (distance region_2 base_1) 842.424)

    (= (distance base_2 region_2) 54.654)
    (= (distance region_2 base_2) 54.654)

    (= (distance base_3 region_2) 76.423)
    (= (distance region_2 base_3) 76.423)

    ; Region 1 with bases
    (= (distance base_1 region_1) 42.432)
    (= (distance region_1 base_1) 42.432)

    (= (distance base_2 region_1) 342.432)
    (= (distance region_1 base_2) 342.432)

    (= (distance base_3 region_1) 88.345)
    (= (distance region_1 base_3) 88.345)

    ; Region 5 with bases
    (= (distance base_1 region_5) 54.5435)
    (= (distance region_5 base_1) 54.5435)

    (= (distance base_2 region_5) 67.088)
    (= (distance region_5 base_2) 67.088)

    (= (distance base_3 region_5) 42.535)
    (= (distance region_5 base_3) 42.535)

    ; Region 6 with bases
    (= (distance base_1 region_6) 545.535)
    (= (distance region_6 base_1) 545.535)

    (= (distance base_2 region_6) 344.563)
    (= (distance region_6 base_2) 344.563)

    (= (distance base_3 region_6) 66.533)
    (= (distance region_6 base_3) 66.533)

    ; Region 4 with bases
    (= (distance base_1 region_4) 23.543)
    (= (distance region_4 base_1) 23.543)

    (= (distance base_2 region_4) 75.765)
    (= (distance region_4 base_2) 75.765)

    (= (distance base_3 region_4) 43.453)
    (= (distance region_4 base_3) 43.453)

    ; Base distance with one another
    (= (distance base_1 base_2) 45.534)
    (= (distance base_2 base_1) 45.534)

    (= (distance base_1 base_3) 745.432)
    (= (distance base_3 base_1) 745.432)

    (= (distance base_2 base_3) 543.45)
    (= (distance base_3 base_2) 543.45)


    (= (velocity) 5.75)


    (= (mission-length) 0)

)
(:goal (and
    (taken-image region_1)
    (taken-image region_4)
    (taken-image region_6)
    (pulverized region_1)
    (pulverized region_5)
    (pulverized region_2)
    (pulverized region_4)

))
(:metric minimize (mission-length))
)
