(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 region_7 region_8 - region
    base_1 base_2 base_3 - base
)
(:init
    (at_regions base_1)


    (= (battery-amount) 72)

    (= (input-amount) 1)

    (= (discharge-rate-battery) 0.0519)

    (= (battery-capacity) 100)

    (= (input-capacity) 4)


    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 53)
    (= (distance region_2 region_1) 53)

    (= (distance region_1 region_3) 633)
    (= (distance region_3 region_1) 633)

    (= (distance region_1 region_4) 53)
    (= (distance region_4 region_1) 53)

    (= (distance region_1 region_5) 75)
    (= (distance region_5 region_1) 75)

    (= (distance region_1 region_6) 247)
    (= (distance region_6 region_1) 247)

    (= (distance region_1 region_7) 255)
    (= (distance region_7 region_1) 255)

    (= (distance region_1 region_8) 93)
    (= (distance region_8 region_1) 93)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 452)
    (= (distance region_3 region_2) 452)

    (= (distance region_2 region_4) 331)
    (= (distance region_4 region_2) 331)

    (= (distance region_2 region_5) 117)
    (= (distance region_5 region_2) 117)

    (= (distance region_2 region_6) 63)
    (= (distance region_6 region_2) 63)

    (= (distance region_2 region_7) 35)
    (= (distance region_7 region_2) 35)

    (= (distance region_2 region_8) 63)
    (= (distance region_8 region_2) 63)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 535)
    (= (distance region_4 region_3) 535)

    (= (distance region_3 region_5) 733)
    (= (distance region_5 region_3) 733)

    (= (distance region_3 region_6) 348)
    (= (distance region_6 region_3) 348)

    (= (distance region_3 region_7) 542)
    (= (distance region_7 region_3) 542)
    
    (= (distance region_3 region_8) 642)
    (= (distance region_8 region_3) 642)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 234)
    (= (distance region_5 region_4) 234)

    (= (distance region_4 region_6) 653)
    (= (distance region_6 region_4) 653)

    (= (distance region_4 region_7) 329)
    (= (distance region_7 region_4) 329)

    (= (distance region_4 region_8) 42)
    (= (distance region_8 region_4) 42)

    ; Region 5 distance with other regions
    (= (distance region_5 region_6) 631)
    (= (distance region_6 region_5) 631)

    (= (distance region_5 region_7) 433)
    (= (distance region_7 region_5) 433)

    (= (distance region_5 region_8) 81)
    (= (distance region_8 region_5) 81)

    ; Region 6 distance with other regions
    (= (distance region_6 region_7) 245)
    (= (distance region_7 region_6) 245)

    (= (distance region_6 region_8) 522)
    (= (distance region_8 region_6) 522)

    ; Region 7 distance with other regions
    (= (distance region_7 region_8) 60)
    (= (distance region_8 region_7) 60)

    ; Region 2 with bases
    (= (distance base_1 region_2) 425)
    (= (distance region_2 base_1) 425)

    (= (distance base_2 region_2) 333)
    (= (distance region_2 base_2) 333)

    (= (distance base_3 region_2) 77)
    (= (distance region_2 base_3) 77)

    ; Region 1 with bases
    (= (distance base_1 region_1) 543)
    (= (distance region_1 base_1) 543)

    (= (distance base_2 region_1) 257)
    (= (distance region_1 base_2) 257)

    (= (distance base_3 region_1) 654)
    (= (distance region_1 base_3) 654)

    ; Region 5 with bases
    (= (distance base_1 region_5) 337)
    (= (distance region_5 base_1) 337)

    (= (distance base_2 region_5) 284)
    (= (distance region_5 base_2) 284)

    (= (distance base_3 region_5) 432)
    (= (distance region_5 base_3) 432)

    ; Region 6 with bases
    (= (distance base_1 region_6) 59)
    (= (distance region_6 base_1) 59)

    (= (distance base_2 region_6) 85)
    (= (distance region_6 base_2) 85)

    (= (distance base_3 region_6) 375)
    (= (distance region_6 base_3) 375)

    ; Region 3 with bases
    (= (distance base_1 region_3) 440)
    (= (distance region_3 base_1) 440)

    (= (distance base_2 region_3) 64)
    (= (distance region_3 base_2) 64)

    (= (distance base_3 region_3) 533)
    (= (distance region_3 base_3) 533)

    ; Region 4 with bases
    (= (distance base_1 region_4) 53)
    (= (distance region_4 base_1) 53)

    (= (distance base_2 region_4) 321)
    (= (distance region_4 base_2) 321)

    (= (distance base_3 region_4) 743)
    (= (distance region_4 base_3) 743)

    ; Region 7 with bases
    (= (distance base_1 region_7) 321)
    (= (distance region_7 base_1) 321)

    (= (distance base_2 region_7) 43)
    (= (distance region_7 base_2) 43)

    (= (distance base_3 region_7) 64)
    (= (distance region_7 base_3) 64)

    ; Region 8 with bases
    (= (distance base_1 region_8) 77)
    (= (distance region_8 base_1) 77)

    (= (distance base_2 region_8) 543)
    (= (distance region_8 base_2) 543)

    (= (distance base_3 region_8) 64)
    (= (distance region_8 base_3) 64)

    ; Base distance with one another
    (= (distance base_1 base_2) 111)
    (= (distance base_2 base_1) 111)

    (= (distance base_1 base_3) 464)
    (= (distance base_3 base_1) 464)

    (= (distance base_2 base_3) 86)
    (= (distance base_3 base_2) 86)


    (= (velocity) 3.0)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)