(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 region_7 - region
    base_1 base_2 base_3 - base
)
(:init
    (at_regions base_1)


    (= (battery-amount) 53)

    (= (input-amount) 2)

    (= (discharge-rate-battery) 0.0402)

    (= (battery-capacity) 85)

    (= (input-capacity) 5)


    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 543)
    (= (distance region_2 region_1) 543)

    (= (distance region_1 region_3) 35)
    (= (distance region_3 region_1) 35)

    (= (distance region_1 region_4) 533)
    (= (distance region_4 region_1) 533)

    (= (distance region_1 region_5) 532)
    (= (distance region_5 region_1) 532)

    (= (distance region_1 region_6) 451)
    (= (distance region_6 region_1) 451)

    (= (distance region_1 region_7) 642)
    (= (distance region_7 region_1) 642)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 234)
    (= (distance region_3 region_2) 234)

    (= (distance region_2 region_4) 653)
    (= (distance region_4 region_2) 653)

    (= (distance region_2 region_5) 349)
    (= (distance region_5 region_2) 349)

    (= (distance region_2 region_6) 342)
    (= (distance region_6 region_2) 342)

    (= (distance region_2 region_7) 442)
    (= (distance region_7 region_2) 442)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 438)
    (= (distance region_4 region_3) 438)

    (= (distance region_3 region_5) 449)
    (= (distance region_5 region_3) 449)

    (= (distance region_3 region_6) 793)
    (= (distance region_6 region_3) 793)

    (= (distance region_3 region_7) 683)
    (= (distance region_7 region_3) 683)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 346)
    (= (distance region_5 region_4) 346)

    (= (distance region_4 region_6) 643)
    (= (distance region_6 region_4) 643)

    (= (distance region_4 region_7) 611)
    (= (distance region_7 region_4) 611)

    ; Region 6 distance with other regions
    (= (distance region_5 region_6) 453)
    (= (distance region_6 region_5) 453)

    (= (distance region_5 region_7) 324)
    (= (distance region_7 region_5) 324)

    ; Region 6 and 7 distance with other regions
    (= (distance region_6 region_7) 38)
    (= (distance region_7 region_6) 38)

    ; Region 2 with bases
    (= (distance base_1 region_2) 53)
    (= (distance region_2 base_1) 53)

    (= (distance base_2 region_2) 64)
    (= (distance region_2 base_2) 64)

    (= (distance base_3 region_2) 425)
    (= (distance region_2 base_3) 425)

    ; Region 1 with bases
    (= (distance base_1 region_1) 278)
    (= (distance region_1 base_1) 278)

    (= (distance base_2 region_1) 432)
    (= (distance region_1 base_2) 432)

    (= (distance base_3 region_1) 131)
    (= (distance region_1 base_3) 131)

    ; Region 5 with bases
    (= (distance base_1 region_5) 327)
    (= (distance region_5 base_1) 327)

    (= (distance base_2 region_5) 231)
    (= (distance region_5 base_2) 231)

    (= (distance base_3 region_5) 53)
    (= (distance region_5 base_3) 53)

    ; Region 6 with bases
    (= (distance base_1 region_6) 588)
    (= (distance region_6 base_1) 588)

    (= (distance base_2 region_6) 774)
    (= (distance region_6 base_2) 774)

    (= (distance base_3 region_6) 52)
    (= (distance region_6 base_3) 52)

    ; Region 3 with bases
    (= (distance base_1 region_3) 612)
    (= (distance region_3 base_1) 612)

    (= (distance base_2 region_3) 88)
    (= (distance region_3 base_2) 88)

    (= (distance base_3 region_3) 533)
    (= (distance region_3 base_3) 533)

    ; Region 4 with bases
    (= (distance base_1 region_4) 332)
    (= (distance region_4 base_1) 332)

    (= (distance base_2 region_4) 21)
    (= (distance region_4 base_2) 21)

    (= (distance base_3 region_4) 167)
    (= (distance region_4 base_3) 167)

    ; Region 7 with bases
    (= (distance base_1 region_7) 245)
    (= (distance region_7 base_1) 245)

    (= (distance base_2 region_7) 43)
    (= (distance region_7 base_2) 43)

    (= (distance base_3 region_7) 32)
    (= (distance region_7 base_3) 32)

    ; Base distance with one another
    (= (distance base_1 base_2) 111)
    (= (distance base_2 base_1) 111)

    (= (distance base_1 base_3) 222)
    (= (distance base_3 base_1) 222)

    (= (distance base_2 base_3) 58)
    (= (distance base_3 base_2) 58)


    (= (velocity) 2.1)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)