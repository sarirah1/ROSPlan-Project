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
    (pulverize-goal region_3)
    (pulverize-goal region_4)

    (= (battery-amount) 10)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.0937)

    (= (battery-capacity) 36)

    (= (input-capacity) 1)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 543.234)
    (= (distance region_2 region_1) 543.234)

    (= (distance region_1 region_3) 430.232)
    (= (distance region_3 region_1) 430.232)

    (= (distance region_1 region_4) 231.862)
    (= (distance region_4 region_1) 231.862)

    (= (distance region_1 region_5) 642.342)
    (= (distance region_5 region_1) 642.342)

    (= (distance region_1 region_6) 862.134)
    (= (distance region_6 region_1) 862.134)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 234.123)
    (= (distance region_3 region_2) 234.123)

    (= (distance region_2 region_4) 987.234)
    (= (distance region_4 region_2) 987.234)

    (= (distance region_2 region_5) 432.219)
    (= (distance region_5 region_2) 432.219)

    (= (distance region_2 region_6) 249.635)
    (= (distance region_6 region_2) 249.635)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 259.643)
    (= (distance region_4 region_3) 259.643)

    (= (distance region_3 region_5) 450.752)
    (= (distance region_5 region_3) 450.752)

    (= (distance region_3 region_6) 543.565)
    (= (distance region_6 region_3) 543.565)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 23.546)
    (= (distance region_5 region_4) 23.546)

    (= (distance region_4 region_6) 86.535)
    (= (distance region_6 region_4) 86.535)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 654.876)
    (= (distance region_6 region_5) 654.876)

    ; Region 2 with bases
    (= (distance base_1 region_2) 549.753)
    (= (distance region_2 base_1) 549.753)

    (= (distance base_2 region_2) 214.754)
    (= (distance region_2 base_2) 214.754)

    (= (distance base_3 region_2) 657.243)
    (= (distance region_2 base_3) 657.243)

    ; Region 1 with bases
    (= (distance base_1 region_1) 453.753)
    (= (distance region_1 base_1) 453.753)

    (= (distance base_2 region_1) 675.234)
    (= (distance region_1 base_2) 675.234)

    (= (distance base_3 region_1) 1435.534)
    (= (distance region_1 base_3) 1435.534)

    ; Region 5 with bases
    (= (distance base_1 region_5) 432.546)
    (= (distance region_5 base_1) 432.546)

    (= (distance base_2 region_5) 876.423)
    (= (distance region_5 base_2) 876.423)

    (= (distance base_3 region_5) 325.654)
    (= (distance region_5 base_3) 325.654)

    ; Region 6 with bases
    (= (distance base_1 region_6) 645.532)
    (= (distance region_6 base_1) 645.532)

    (= (distance base_2 region_6) 785.654)
    (= (distance region_6 base_2) 785.654)

    (= (distance base_3 region_6) 122.432)
    (= (distance region_6 base_3) 122.432)

    ; Region 3 with bases
    (= (distance base_1 region_3) 555.433)
    (= (distance region_3 base_1) 555.433)

    (= (distance base_2 region_3) 33.424)
    (= (distance region_3 base_2) 33.424)

    (= (distance base_3 region_3) 44.645)
    (= (distance region_3 base_3) 44.645)

    ; Region 4 with bases
    (= (distance base_1 region_4) 356.765)
    (= (distance region_4 base_1) 356.765)

    (= (distance base_2 region_4) 244.356)
    (= (distance region_4 base_2) 244.356)

    (= (distance base_3 region_4) 455.244)
    (= (distance region_4 base_3) 455.244)

    ; Base distance with one another
    (= (distance base_1 base_2) 453.247)
    (= (distance base_2 base_1) 453.247)

    (= (distance base_1 base_3) 437.534)
    (= (distance base_3 base_1) 437.534)

    (= (distance base_2 base_3) 551.962)
    (= (distance base_3 base_2) 551.962)


    (= (velocity) 8.55)


    (= (mission-length) 0)

)
(:goal (and
    (taken-image region_5)
    (taken-image region_6)
    (taken-image region_1)
    (taken-image region_2)
    (pulverized region_1)
    (pulverized region_6)
    (pulverized region_3)
    (pulverized region_4)

))
(:metric minimize (mission-length))
)
