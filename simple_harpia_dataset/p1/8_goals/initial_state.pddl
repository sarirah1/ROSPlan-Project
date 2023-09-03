(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 region_7 - region
    base_1 base_2 base_3 - base
)
(:init
    (at_regions base_1)


    (= (battery-amount) 44)

    (= (input-amount) 1)

    (= (discharge-rate-battery) 0.052)

    (= (battery-capacity) 80)

    (= (input-capacity) 4)


    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 448)
    (= (distance region_2 region_1) 448)

    (= (distance region_1 region_3) 753)
    (= (distance region_3 region_1) 753)

    (= (distance region_1 region_4) 642)
    (= (distance region_4 region_1) 642)

    (= (distance region_1 region_5) 852)
    (= (distance region_5 region_1) 852)

    (= (distance region_1 region_6) 135)
    (= (distance region_6 region_1) 135)

    (= (distance region_1 region_7) 642)
    (= (distance region_7 region_1) 642)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 562)
    (= (distance region_3 region_2) 562)

    (= (distance region_2 region_4) 649)
    (= (distance region_4 region_2) 649)

    (= (distance region_2 region_5) 342)
    (= (distance region_5 region_2) 342)

    (= (distance region_2 region_6) 742)
    (= (distance region_6 region_2) 742)

    (= (distance region_2 region_7) 358)
    (= (distance region_7 region_2) 358)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 222)
    (= (distance region_4 region_3) 222)

    (= (distance region_3 region_5) 532)
    (= (distance region_5 region_3) 532)

    (= (distance region_3 region_6) 289)
    (= (distance region_6 region_3) 289)

    (= (distance region_3 region_7) 469)
    (= (distance region_7 region_3) 469)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 765)
    (= (distance region_5 region_4) 765)

    (= (distance region_4 region_6) 741)
    (= (distance region_6 region_4) 741)

    (= (distance region_4 region_7) 632)
    (= (distance region_7 region_4) 632)

    ; Region 6 distance with other regions
    (= (distance region_5 region_6) 123)
    (= (distance region_6 region_5) 123)

    (= (distance region_5 region_7) 42)
    (= (distance region_7 region_5) 42)

    ; Region 6 and 7 distance with other regions
    (= (distance region_6 region_7) 246)
    (= (distance region_7 region_6) 246)

    ; Region 2 with bases
    (= (distance base_1 region_2) 384)
    (= (distance region_2 base_1) 384)

    (= (distance base_2 region_2) 244)
    (= (distance region_2 base_2) 244)

    (= (distance base_3 region_2) 223)
    (= (distance region_2 base_3) 223)

    ; Region 1 with bases
    (= (distance base_1 region_1) 44)
    (= (distance region_1 base_1) 44)

    (= (distance base_2 region_1) 654)
    (= (distance region_1 base_2) 654)

    (= (distance base_3 region_1) 432)
    (= (distance region_1 base_3) 432)

    ; Region 5 with bases
    (= (distance base_1 region_5) 451)
    (= (distance region_5 base_1) 451)

    (= (distance base_2 region_5) 82)
    (= (distance region_5 base_2) 82)

    (= (distance base_3 region_5) 432)
    (= (distance region_5 base_3) 432)

    ; Region 6 with bases
    (= (distance base_1 region_6) 322)
    (= (distance region_6 base_1) 322)

    (= (distance base_2 region_6) 43)
    (= (distance region_6 base_2) 43)

    (= (distance base_3 region_6) 654)
    (= (distance region_6 base_3) 654)

    ; Region 3 with bases
    (= (distance base_1 region_3) 24)
    (= (distance region_3 base_1) 24)

    (= (distance base_2 region_3) 64)
    (= (distance region_3 base_2) 64)

    (= (distance base_3 region_3) 722)
    (= (distance region_3 base_3) 722)

    ; Region 4 with bases
    (= (distance base_1 region_4) 432)
    (= (distance region_4 base_1) 432)

    (= (distance base_2 region_4) 32)
    (= (distance region_4 base_2) 32)

    (= (distance base_3 region_4) 54)
    (= (distance region_4 base_3) 54)

    ; Region 7 with bases
    (= (distance base_1 region_7) 72)
    (= (distance region_7 base_1) 72)

    (= (distance base_2 region_7) 347)
    (= (distance region_7 base_2) 347)

    (= (distance base_3 region_7) 64)
    (= (distance region_7 base_3) 64)

    ; Base distance with one another
    (= (distance base_1 base_2) 24)
    (= (distance base_2 base_1) 24)

    (= (distance base_1 base_3) 644)
    (= (distance base_3 base_1) 644)

    (= (distance base_2 base_3) 129)
    (= (distance base_3 base_2) 129)


    (= (velocity) 2.7)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)