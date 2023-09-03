(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 region_7 region_8 - region
    base_1 base_2 base_3 - base
)
(:init
    (at_regions base_1)


    (= (battery-amount) 54)

    (= (input-amount) 0)

    (= (discharge-rate-battery) 0.0329)

    (= (battery-capacity) 68)

    (= (input-capacity) 4)


    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 74)
    (= (distance region_2 region_1) 74)

    (= (distance region_1 region_3) 63)
    (= (distance region_3 region_1) 63)

    (= (distance region_1 region_4) 744)
    (= (distance region_4 region_1) 744)

    (= (distance region_1 region_5) 342)
    (= (distance region_5 region_1) 342)

    (= (distance region_1 region_6) 531)
    (= (distance region_6 region_1) 531)

    (= (distance region_1 region_7) 255)
    (= (distance region_7 region_1) 255)

    (= (distance region_1 region_8) 125)
    (= (distance region_8 region_1) 125)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 324)
    (= (distance region_3 region_2) 324)

    (= (distance region_2 region_4) 511)
    (= (distance region_4 region_2) 511)

    (= (distance region_2 region_5) 345)
    (= (distance region_5 region_2) 345)

    (= (distance region_2 region_6) 228)
    (= (distance region_6 region_2) 228)

    (= (distance region_2 region_7) 432)
    (= (distance region_7 region_2) 432)

    (= (distance region_2 region_8) 341)
    (= (distance region_8 region_2) 341)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 339)
    (= (distance region_4 region_3) 339)

    (= (distance region_3 region_5) 49)
    (= (distance region_5 region_3) 49)

    (= (distance region_3 region_6) 742)
    (= (distance region_6 region_3) 742)

    (= (distance region_3 region_7) 331)
    (= (distance region_7 region_3) 331)
    
    (= (distance region_3 region_8) 21)
    (= (distance region_8 region_3) 21)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 301)
    (= (distance region_5 region_4) 301)

    (= (distance region_4 region_6) 521)
    (= (distance region_6 region_4) 521)

    (= (distance region_4 region_7) 448)
    (= (distance region_7 region_4) 448)

    (= (distance region_4 region_8) 340)
    (= (distance region_8 region_4) 340)

    ; Region 5 distance with other regions
    (= (distance region_5 region_6) 621)
    (= (distance region_6 region_5) 621)

    (= (distance region_5 region_7) 51)
    (= (distance region_7 region_5) 51)

    (= (distance region_5 region_8) 71)
    (= (distance region_8 region_5) 71)

    ; Region 6 distance with other regions
    (= (distance region_6 region_7) 88)
    (= (distance region_7 region_6) 88)

    (= (distance region_6 region_8) 419)
    (= (distance region_8 region_6) 419)

    ; Region 7 distance with other regions
    (= (distance region_7 region_8) 83)
    (= (distance region_8 region_7) 83)

    ; Region 2 with bases
    (= (distance base_1 region_2) 306)
    (= (distance region_2 base_1) 306)

    (= (distance base_2 region_2) 730)
    (= (distance region_2 base_2) 730)

    (= (distance base_3 region_2) 52)
    (= (distance region_2 base_3) 52)

    ; Region 1 with bases
    (= (distance base_1 region_1) 43)
    (= (distance region_1 base_1) 43)

    (= (distance base_2 region_1) 523)
    (= (distance region_1 base_2) 523)

    (= (distance base_3 region_1) 311)
    (= (distance region_1 base_3) 311)

    ; Region 5 with bases
    (= (distance base_1 region_5) 50)
    (= (distance region_5 base_1) 50)

    (= (distance base_2 region_5) 534)
    (= (distance region_5 base_2) 534)

    (= (distance base_3 region_5) 194)
    (= (distance region_5 base_3) 194)

    ; Region 6 with bases
    (= (distance base_1 region_6) 266)
    (= (distance region_6 base_1) 266)

    (= (distance base_2 region_6) 53)
    (= (distance region_6 base_2) 53)

    (= (distance base_3 region_6) 294)
    (= (distance region_6 base_3) 294)

    ; Region 3 with bases
    (= (distance base_1 region_3) 274)
    (= (distance region_3 base_1) 274)

    (= (distance base_2 region_3) 304)
    (= (distance region_3 base_2) 304)

    (= (distance base_3 region_3) 39)
    (= (distance region_3 base_3) 39)

    ; Region 4 with bases
    (= (distance base_1 region_4) 693)
    (= (distance region_4 base_1) 693)

    (= (distance base_2 region_4) 73)
    (= (distance region_4 base_2) 73)

    (= (distance base_3 region_4) 83)
    (= (distance region_4 base_3) 83)

    ; Region 7 with bases
    (= (distance base_1 region_7) 832)
    (= (distance region_7 base_1) 832)

    (= (distance base_2 region_7) 74)
    (= (distance region_7 base_2) 74)

    (= (distance base_3 region_7) 110)
    (= (distance region_7 base_3) 110)

    ; Region 8 with bases
    (= (distance base_1 region_8) 77)
    (= (distance region_8 base_1) 77)

    (= (distance base_2 region_8) 296)
    (= (distance region_8 base_2) 296)

    (= (distance base_3 region_8) 39)
    (= (distance region_8 base_3) 39)

    ; Base distance with one another
    (= (distance base_1 base_2) 104)
    (= (distance base_2 base_1) 104)

    (= (distance base_1 base_3) 295)
    (= (distance base_3 base_1) 295)

    (= (distance base_2 base_3) 306)
    (= (distance base_3 base_2) 306)


    (= (velocity) 3.4)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)