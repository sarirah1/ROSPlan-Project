(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base
)
(:init
    (at_regions base_1)


    (= (battery-amount) 50)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.042)

    (= (battery-capacity) 70)

    (= (input-capacity) 3)


    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 642)
    (= (distance region_2 region_1) 642)

    (= (distance region_1 region_3) 531)
    (= (distance region_3 region_1) 531)

    (= (distance region_1 region_4) 430)
    (= (distance region_4 region_1) 430)

    (= (distance region_1 region_5) 519)
    (= (distance region_5 region_1) 519)

    (= (distance region_1 region_6) 954)
    (= (distance region_6 region_1) 954)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 432)
    (= (distance region_3 region_2) 432)

    (= (distance region_2 region_4) 751)
    (= (distance region_4 region_2) 751)

    (= (distance region_2 region_5) 773)
    (= (distance region_5 region_2) 773)

    (= (distance region_2 region_6) 221)
    (= (distance region_6 region_2) 221)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 641)
    (= (distance region_4 region_3) 641)

    (= (distance region_3 region_5) 421)
    (= (distance region_5 region_3) 421)

    (= (distance region_3 region_6) 845)
    (= (distance region_6 region_3) 845)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 355)
    (= (distance region_5 region_4) 355)

    (= (distance region_4 region_6) 93)
    (= (distance region_6 region_4) 93)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 42)
    (= (distance region_6 region_5) 42)

    ; Region 2 with bases
    (= (distance base_1 region_2) 384)
    (= (distance region_2 base_1) 384)

    (= (distance base_2 region_2) 523)
    (= (distance region_2 base_2) 523)

    (= (distance base_3 region_2) 223)
    (= (distance region_2 base_3) 223)

    ; Region 1 with bases
    (= (distance base_1 region_1) 423)
    (= (distance region_1 base_1) 423)

    (= (distance base_2 region_1) 552)
    (= (distance region_1 base_2) 552)

    (= (distance base_3 region_1) 67)
    (= (distance region_1 base_3) 67)

    ; Region 5 with bases
    (= (distance base_1 region_5) 54)
    (= (distance region_5 base_1) 54)

    (= (distance base_2 region_5) 543)
    (= (distance region_5 base_2) 543)

    (= (distance base_3 region_5) 23)
    (= (distance region_5 base_3) 23)

    ; Region 6 with bases
    (= (distance base_1 region_6) 636)
    (= (distance region_6 base_1) 636)

    (= (distance base_2 region_6) 432)
    (= (distance region_6 base_2) 432)

    (= (distance base_3 region_6) 553)
    (= (distance region_6 base_3) 553)

    ; Region 3 with bases
    (= (distance base_1 region_3) 470)
    (= (distance region_3 base_1) 470)

    (= (distance base_2 region_3) 345)
    (= (distance region_3 base_2) 345)

    (= (distance base_3 region_3) 74)
    (= (distance region_3 base_3) 74)

    ; Region 4 with bases
    (= (distance base_1 region_4) 546)
    (= (distance region_4 base_1) 546)

    (= (distance base_2 region_4) 772)
    (= (distance region_4 base_2) 772)

    (= (distance base_3 region_4) 492)
    (= (distance region_4 base_3) 492)

    ; Base distance with one another
    (= (distance base_1 base_2) 425)
    (= (distance base_2 base_1) 425)

    (= (distance base_1 base_3) 74)
    (= (distance base_3 base_1) 74)

    (= (distance base_2 base_3) 86)
    (= (distance base_3 base_2) 86)


    (= (velocity) 3.5)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)