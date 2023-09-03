(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base

    robot_1 - ground
    robot_3 robot_4 - aerial
    box_1 box_2 - box
    crop_1 crop_2 crop_3 crop_4 crop_5 crop_6 crop_7 crop_8 - crop
    livestock_1 livestock_2 livestock_3 livestock_4 livestock_5 livestock_6 livestock_7 - livestock
    crop_1_location crop_2_location crop_3_location crop_4_location crop_5_location crop_6_location crop_7_location crop_8_location robot_initial_location box_1_location box_2_location livestock_1_location livestock_2_location livestock_3_location livestock_4_location livestock_5_location livestock_6_location livestock_7_location - position
    station_1 - charging-station
    produce_1 produce_2 produce_3 produce_4 produce_5 produce_6 produce_7 - produce

)
(:init
    (aerial_at robot_3 base_1)
    (aerial_at robot_4 base_3)

    (= (battery-amount robot_1) 44)
    ; (= (battery-amount robot_2) 39)
    (= (battery-amount robot_3) 41)
    (= (battery-amount robot_4) 16)

    ; (= (input-amount robot_1) 1)
    (= (input-amount robot_3) 1)
    (= (input-amount robot_4) 2)

    (robot_at robot_1 robot_initial_location)
    ; (robot_at robot_2 robot_2_location)

    (crop_at crop_1 crop_1_location)
    (crop_at crop_2 crop_2_location)
    (crop_at crop_3 crop_3_location)
    (crop_at crop_4 crop_4_location)
    (crop_at crop_5 crop_5_location)
    (crop_at crop_6 crop_6_location)
    (crop_at crop_7 crop_7_location)
    (crop_at crop_8 crop_8_location)

    (box_at box_1 box_1_location)
    (box_at box_2 box_2_location)

    (crop-ripe crop_1 crop_1_location)
    (crop-ripe crop_2 crop_2_location)
    (crop-ripe crop_3 crop_3_location)
    (crop-ripe crop_4 crop_4_location)
    (crop-ripe crop_5 crop_5_location)
    (crop-ripe crop_6 crop_6_location)
    (crop-ripe crop_7 crop_7_location)
    (crop-ripe crop_8 crop_8_location)

    (hand-free robot_1)
    ; (hand-free robot_2)


    (object_at livestock_1 livestock_1_location)
    (object_at livestock_2 livestock_2_location)
    (object_at livestock_3 livestock_3_location)
    (object_at livestock_4 livestock_4_location)
    (object_at livestock_5 livestock_5_location)
    (object_at livestock_6 livestock_6_location)
    (object_at livestock_7 livestock_7_location)


    (livestock-hungry livestock_1)
    (livestock-hungry livestock_2)
    (livestock-hungry livestock_3)
    (livestock-hungry livestock_4)
    (livestock-hungry livestock_5)
    (livestock-hungry livestock_6)
    (livestock-hungry livestock_7)

    (belong_to produce_1 livestock_1)
    (belong_to produce_2 livestock_2)
    (belong_to produce_3 livestock_3)
    (belong_to produce_4 livestock_4)
    (belong_to produce_5 livestock_5)
    (belong_to produce_6 livestock_6)
    (belong_to produce_7 livestock_7)

    (= (food-amount robot_1) 0)
    ; (= (food-amount robot_2) 1)

    (= (food-capacity) 2)

    (= (water-amount robot_1) 1)
    ; (= (water-amount robot_2) 1)

    (= (water-capacity) 1)

    (= (discharge-rate-battery) 0.0613)

    (= (battery-capacity) 70)

    (= (input-capacity) 1)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 252)
    (= (distance region_2 region_1) 252)

    (= (distance region_1 region_3) 643)
    (= (distance region_3 region_1) 643)

    (= (distance region_1 region_4) 646)
    (= (distance region_4 region_1) 646)

    (= (distance region_1 region_5) 221)
    (= (distance region_5 region_1) 221)

    (= (distance region_1 region_6) 249)
    (= (distance region_6 region_1) 249)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 258)
    (= (distance region_3 region_2) 258)

    (= (distance region_2 region_4) 110)
    (= (distance region_4 region_2) 110)

    (= (distance region_2 region_5) 632)
    (= (distance region_5 region_2) 632)

    (= (distance region_2 region_6) 853)
    (= (distance region_6 region_2) 853)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 351)
    (= (distance region_4 region_3) 351)

    (= (distance region_3 region_5) 341)
    (= (distance region_5 region_3) 341)

    (= (distance region_3 region_6) 831)
    (= (distance region_6 region_3) 831)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 741)
    (= (distance region_5 region_4) 741)

    (= (distance region_4 region_6) 542)
    (= (distance region_6 region_4) 542)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 453)
    (= (distance region_6 region_5) 453)

    ; Region 2 with bases
    (= (distance base_1 region_2) 253)
    (= (distance region_2 base_1) 253)

    (= (distance base_2 region_2) 141)
    (= (distance region_2 base_2) 141)

    (= (distance base_3 region_2) 756)
    (= (distance region_2 base_3) 756)

    ; Region 1 with bases
    (= (distance base_1 region_1) 642)
    (= (distance region_1 base_1) 642)

    (= (distance base_2 region_1) 156)
    (= (distance region_1 base_2) 156)

    (= (distance base_3 region_1) 745)
    (= (distance region_1 base_3) 745)

    ; Region 5 with bases
    (= (distance base_1 region_5) 149)
    (= (distance region_5 base_1) 149)

    (= (distance base_2 region_5) 421)
    (= (distance region_5 base_2) 421)

    (= (distance base_3 region_5) 752)
    (= (distance region_5 base_3) 752)

    ; Region 6 with bases
    (= (distance base_1 region_6) 963)
    (= (distance region_6 base_1) 963)

    (= (distance base_2 region_6) 232)
    (= (distance region_6 base_2) 232)

    (= (distance base_3 region_6) 142)
    (= (distance region_6 base_3) 142)

    ; Region 3 with bases
    (= (distance base_1 region_3) 211)
    (= (distance region_3 base_1) 211)

    (= (distance base_2 region_3) 532)
    (= (distance region_3 base_2) 532)

    (= (distance base_3 region_3) 342)
    (= (distance region_3 base_3) 241)

    ; Region 4 with bases
    (= (distance base_1 region_4) 124)
    (= (distance region_4 base_1) 124)

    (= (distance base_2 region_4) 314)
    (= (distance region_4 base_2) 314)

    (= (distance base_3 region_4) 121)
    (= (distance region_4 base_3) 121)

    ; Base distance with one another
    (= (distance base_1 base_2) 196)
    (= (distance base_2 base_1) 196)

    (= (distance base_1 base_3) 135)
    (= (distance base_3 base_1) 135)

    (= (distance base_2 base_3) 157)
    (= (distance base_3 base_2) 157)




   ; Distance between crop 1 and everthing else
    (= (distance_location crop_1_location crop_2_location) 17)
    (= (distance_location crop_2_location crop_1_location) 17)

    (= (distance_location crop_1_location crop_3_location) 65)
    (= (distance_location crop_3_location crop_1_location) 65)

    (= (distance_location crop_1_location crop_4_location) 26)
    (= (distance_location crop_4_location crop_1_location) 26)

    (= (distance_location crop_1_location crop_5_location) 17)
    (= (distance_location crop_5_location crop_1_location) 17)

    (= (distance_location crop_1_location crop_6_location) 63)
    (= (distance_location crop_6_location crop_1_location) 63)

    (= (distance_location crop_1_location crop_7_location) 72)
    (= (distance_location crop_7_location crop_1_location) 72)

    (= (distance_location crop_1_location crop_8_location) 58)
    (= (distance_location crop_8_location crop_1_location) 58)

    (= (distance_location crop_1_location robot_initial_location) 93)
    (= (distance_location robot_initial_location crop_1_location) 93)
    
    (= (distance_location crop_1_location box_1_location) 53)
    (= (distance_location box_1_location crop_1_location) 53)

    (= (distance_location crop_1_location box_2_location) 85)
    (= (distance_location box_2_location crop_1_location) 85)

    (= (distance_location crop_1_location station_1) 8)
    (= (distance_location station_1 crop_1_location) 8)

    (= (distance_location crop_1_location livestock_1_location) 42)
    (= (distance_location livestock_1_location crop_1_location) 42)

    (= (distance_location crop_1_location livestock_2_location) 81)
    (= (distance_location livestock_2_location crop_1_location) 81)

    (= (distance_location crop_1_location livestock_3_location) 57)
    (= (distance_location livestock_3_location crop_1_location) 57)

    (= (distance_location crop_1_location livestock_4_location) 72)
    (= (distance_location livestock_4_location crop_1_location) 72)

    (= (distance_location crop_1_location livestock_5_location) 74)
    (= (distance_location livestock_5_location crop_1_location) 74)

    (= (distance_location crop_1_location livestock_6_location) 18)
    (= (distance_location livestock_6_location crop_1_location) 18)

    (= (distance_location crop_1_location livestock_7_location) 36)
    (= (distance_location livestock_7_location crop_1_location) 36)

    ; (= (distance_location crop_1_location robot_2_location) 92)
    ; (= (distance_location robot_2_location crop_1_location) 92)

    ; Distance of crop 2 with everything else
    (= (distance_location crop_2_location crop_3_location) 25)
    (= (distance_location crop_3_location crop_2_location) 25)

    (= (distance_location crop_2_location crop_4_location) 66)
    (= (distance_location crop_4_location crop_2_location) 66)

    (= (distance_location crop_2_location crop_5_location) 25)
    (= (distance_location crop_5_location crop_2_location) 25)
    
    (= (distance_location crop_2_location crop_6_location) 74)
    (= (distance_location crop_6_location crop_2_location) 74)

    (= (distance_location crop_2_location crop_7_location) 18)
    (= (distance_location crop_7_location crop_2_location) 18)

    (= (distance_location crop_2_location crop_8_location) 85)
    (= (distance_location crop_8_location crop_2_location) 85)

    (= (distance_location crop_2_location robot_initial_location) 55)
    (= (distance_location robot_initial_location crop_2_location) 55)
    
    (= (distance_location crop_2_location box_1_location) 63)
    (= (distance_location box_1_location crop_2_location) 63)

    (= (distance_location crop_2_location box_2_location) 36)
    (= (distance_location box_2_location crop_2_location) 36)

    (= (distance_location crop_2_location station_1) 30)
    (= (distance_location station_1 crop_2_location) 30)

    (= (distance_location crop_2_location livestock_1_location) 32)
    (= (distance_location livestock_1_location crop_2_location) 32)

    (= (distance_location crop_2_location livestock_2_location) 41)
    (= (distance_location livestock_2_location crop_2_location) 41)

    (= (distance_location crop_2_location livestock_3_location) 25)
    (= (distance_location livestock_3_location crop_2_location) 25)

    (= (distance_location crop_2_location livestock_4_location) 64)
    (= (distance_location livestock_4_location crop_2_location) 64)

    (= (distance_location crop_2_location livestock_5_location) 25)
    (= (distance_location livestock_5_location crop_2_location) 25)

    (= (distance_location crop_2_location livestock_6_location) 63)
    (= (distance_location livestock_6_location crop_2_location) 63)

    (= (distance_location crop_2_location livestock_7_location) 58)
    (= (distance_location livestock_7_location crop_2_location) 58)

    ; (= (distance_location crop_2_location robot_2_location) 88)
    ; (= (distance_location robot_2_location crop_2_location) 88)

    
    ; Distance of crop 3 with everything else
    (= (distance_location crop_3_location crop_4_location) 97)
    (= (distance_location crop_4_location crop_3_location) 97)

    (= (distance_location crop_3_location crop_5_location) 64)
    (= (distance_location crop_5_location crop_3_location) 64)

    (= (distance_location crop_3_location crop_6_location) 47)
    (= (distance_location crop_6_location crop_3_location) 47)

    (= (distance_location crop_3_location crop_7_location) 74)
    (= (distance_location crop_7_location crop_3_location) 74)

    (= (distance_location crop_3_location crop_8_location) 4)
    (= (distance_location crop_8_location crop_3_location) 4)
    
    (= (distance_location crop_3_location robot_initial_location) 77)
    (= (distance_location robot_initial_location crop_3_location) 77)
    
    (= (distance_location crop_3_location box_1_location) 25)
    (= (distance_location box_1_location crop_3_location) 25)

    (= (distance_location crop_3_location box_2_location) 15)
    (= (distance_location box_2_location crop_3_location) 15)

    (= (distance_location crop_3_location station_1) 25)
    (= (distance_location station_1 crop_3_location) 25)

    (= (distance_location crop_3_location livestock_1_location) 53)
    (= (distance_location livestock_1_location crop_3_location) 53)

    (= (distance_location crop_3_location livestock_2_location) 74)
    (= (distance_location livestock_2_location crop_3_location) 74)

    (= (distance_location crop_3_location livestock_3_location) 96)
    (= (distance_location livestock_3_location crop_3_location) 96)

    (= (distance_location crop_3_location livestock_4_location) 36)
    (= (distance_location livestock_4_location crop_3_location) 36)

    (= (distance_location crop_3_location livestock_5_location) 73)
    (= (distance_location livestock_5_location crop_3_location) 73)

    (= (distance_location crop_3_location livestock_6_location) 22)
    (= (distance_location livestock_6_location crop_3_location) 22)

    (= (distance_location crop_3_location livestock_7_location) 72)
    (= (distance_location livestock_7_location crop_3_location) 72)

    ; (= (distance_location crop_3_location robot_2_location) 39)
    ; (= (distance_location robot_2_location crop_3_location) 39)

    ; Distance of crop 4 with everything else
    (= (distance_location crop_4_location crop_5_location) 24)
    (= (distance_location crop_5_location crop_4_location) 24)
    
    (= (distance_location crop_4_location crop_6_location) 75)
    (= (distance_location crop_6_location crop_4_location) 75)

    (= (distance_location crop_4_location crop_7_location) 74)
    (= (distance_location crop_7_location crop_4_location) 74)

    (= (distance_location crop_4_location crop_8_location) 49)
    (= (distance_location crop_8_location crop_4_location) 49)
    
    (= (distance_location crop_4_location robot_initial_location) 72)
    (= (distance_location robot_initial_location crop_4_location) 72)
    
    (= (distance_location crop_4_location box_1_location) 42)
    (= (distance_location box_1_location crop_4_location) 42)

    (= (distance_location crop_4_location box_2_location) 10)
    (= (distance_location box_2_location crop_4_location) 10)

    (= (distance_location crop_4_location station_1) 63)
    (= (distance_location station_1 crop_4_location) 63)

    (= (distance_location crop_4_location livestock_1_location) 70)
    (= (distance_location livestock_1_location crop_4_location) 70)

    (= (distance_location crop_4_location livestock_2_location) 82)
    (= (distance_location livestock_2_location crop_4_location) 82)

    (= (distance_location crop_4_location livestock_3_location) 63)
    (= (distance_location livestock_3_location crop_4_location) 63)

    (= (distance_location crop_4_location livestock_4_location) 52)
    (= (distance_location livestock_4_location crop_4_location) 52)

    (= (distance_location crop_4_location livestock_5_location) 37)
    (= (distance_location livestock_5_location crop_4_location) 37)

    (= (distance_location crop_4_location livestock_6_location) 72)
    (= (distance_location livestock_6_location crop_4_location) 72)

    (= (distance_location crop_4_location livestock_7_location) 82)
    (= (distance_location livestock_7_location crop_4_location) 82)

    ; (= (distance_location crop_4_location robot_2_location) 85)
    ; (= (distance_location robot_2_location crop_4_location) 85)

    ; Distance of crop 5 with everything else
    (= (distance_location crop_5_location crop_6_location) 52)
    (= (distance_location crop_6_location crop_5_location) 52)

    (= (distance_location crop_5_location crop_7_location) 63)
    (= (distance_location crop_7_location crop_5_location) 63)

    (= (distance_location crop_5_location crop_8_location) 74)
    (= (distance_location crop_8_location crop_5_location) 74)

    (= (distance_location crop_5_location robot_initial_location) 88)
    (= (distance_location robot_initial_location crop_5_location) 88)
    
    (= (distance_location crop_5_location box_1_location) 26)
    (= (distance_location box_1_location crop_5_location) 26)

    (= (distance_location crop_5_location box_2_location) 25)
    (= (distance_location box_2_location crop_5_location) 25)

    (= (distance_location crop_5_location station_1) 74)
    (= (distance_location station_1 crop_5_location) 74)

    (= (distance_location crop_5_location livestock_1_location) 44)
    (= (distance_location livestock_1_location crop_5_location) 44)

    (= (distance_location crop_5_location livestock_2_location) 33)
    (= (distance_location livestock_2_location crop_5_location) 33)

    (= (distance_location crop_5_location livestock_3_location) 84)
    (= (distance_location livestock_3_location crop_5_location) 84)

    (= (distance_location crop_5_location livestock_4_location) 25)
    (= (distance_location livestock_4_location crop_5_location) 25)

    (= (distance_location crop_5_location livestock_5_location) 56)
    (= (distance_location livestock_5_location crop_5_location) 56)

    (= (distance_location crop_5_location livestock_6_location) 37)
    (= (distance_location livestock_6_location crop_5_location) 37)

    (= (distance_location crop_5_location livestock_7_location) 55)
    (= (distance_location livestock_7_location crop_5_location) 55)

    ; (= (distance_location crop_5_location robot_2_location) 43)
    ; (= (distance_location robot_2_location crop_5_location) 43)

    ; Distance of crop 6 with everything else
    (= (distance_location crop_6_location crop_7_location) 53)
    (= (distance_location crop_7_location crop_6_location) 53)

    (= (distance_location crop_6_location crop_8_location) 26)
    (= (distance_location crop_8_location crop_6_location) 26)

    (= (distance_location crop_6_location robot_initial_location) 32)
    (= (distance_location robot_initial_location crop_6_location) 32)
    
    (= (distance_location crop_6_location box_1_location) 66)
    (= (distance_location box_1_location crop_6_location) 66)

    (= (distance_location crop_6_location box_2_location) 82)
    (= (distance_location box_2_location crop_6_location) 82)

    (= (distance_location crop_6_location station_1) 16)
    (= (distance_location station_1 crop_6_location) 16)

    (= (distance_location crop_6_location livestock_1_location) 29)
    (= (distance_location livestock_1_location crop_6_location) 29)

    (= (distance_location crop_6_location livestock_2_location) 36)
    (= (distance_location livestock_2_location crop_6_location) 36)

    (= (distance_location crop_6_location livestock_3_location) 63)
    (= (distance_location livestock_3_location crop_6_location) 63)

    (= (distance_location crop_6_location livestock_4_location) 90)
    (= (distance_location livestock_4_location crop_6_location) 90)

    (= (distance_location crop_6_location livestock_5_location) 53)
    (= (distance_location livestock_5_location crop_6_location) 53)

    (= (distance_location crop_6_location livestock_6_location) 25)
    (= (distance_location livestock_6_location crop_6_location) 25)

    (= (distance_location crop_6_location livestock_7_location) 68)
    (= (distance_location livestock_7_location crop_6_location) 68)

    ; (= (distance_location crop_6_location robot_2_location) 18)
    ; (= (distance_location robot_2_location crop_6_location) 18)

    ; Distance of crop 7 with everything else
    (= (distance_location crop_7_location crop_8_location) 19)
    (= (distance_location crop_8_location crop_7_location) 19)

    (= (distance_location crop_7_location robot_initial_location) 53)
    (= (distance_location robot_initial_location crop_7_location) 53)
    
    (= (distance_location crop_7_location box_1_location) 34)
    (= (distance_location box_1_location crop_7_location) 34)

    (= (distance_location crop_7_location box_2_location) 38)
    (= (distance_location box_2_location crop_7_location) 38)

    (= (distance_location crop_7_location station_1) 26)
    (= (distance_location station_1 crop_7_location) 26)

    (= (distance_location crop_7_location livestock_1_location) 97)
    (= (distance_location livestock_1_location crop_7_location) 97)

    (= (distance_location crop_7_location livestock_2_location) 25)
    (= (distance_location livestock_2_location crop_7_location) 25)

    (= (distance_location crop_7_location livestock_3_location) 62)
    (= (distance_location livestock_3_location crop_7_location) 62)

    (= (distance_location crop_7_location livestock_4_location) 26)
    (= (distance_location livestock_4_location crop_7_location) 26)

    (= (distance_location crop_7_location livestock_5_location) 14)
    (= (distance_location livestock_5_location crop_7_location) 14)

    (= (distance_location crop_7_location livestock_6_location) 72)
    (= (distance_location livestock_6_location crop_7_location) 72)

    (= (distance_location crop_7_location livestock_7_location) 27)
    (= (distance_location livestock_7_location crop_7_location) 27)

    ; (= (distance_location crop_7_location robot_2_location) 84)
    ; (= (distance_location robot_2_location crop_7_location) 84)

    ; Distance of crop 8 with everything else
    (= (distance_location crop_8_location robot_initial_location) 52)
    (= (distance_location robot_initial_location crop_8_location) 52)
    
    (= (distance_location crop_8_location box_1_location) 43)
    (= (distance_location box_1_location crop_8_location) 43)

    (= (distance_location crop_8_location box_2_location) 33)
    (= (distance_location box_2_location crop_8_location) 33)

    (= (distance_location crop_8_location station_1) 8)
    (= (distance_location station_1 crop_8_location) 8)

    (= (distance_location crop_8_location livestock_1_location) 48)
    (= (distance_location livestock_1_location crop_8_location) 48)

    (= (distance_location crop_8_location livestock_2_location) 24)
    (= (distance_location livestock_2_location crop_8_location) 24)

    (= (distance_location crop_8_location livestock_3_location) 66)
    (= (distance_location livestock_3_location crop_8_location) 66)

    (= (distance_location crop_8_location livestock_4_location) 73)
    (= (distance_location livestock_4_location crop_8_location) 73)

    (= (distance_location crop_8_location livestock_5_location) 28)
    (= (distance_location livestock_5_location crop_8_location) 28)

    (= (distance_location crop_8_location livestock_6_location) 68)
    (= (distance_location livestock_6_location crop_8_location) 68)

    (= (distance_location crop_8_location livestock_7_location) 27)
    (= (distance_location livestock_7_location crop_8_location) 27)

    ; (= (distance_location crop_8_location robot_2_location) 85)
    ; (= (distance_location robot_2_location crop_8_location) 85)

    ; Distance between box and robot location
    (= (distance_location robot_initial_location box_1_location) 65)
    (= (distance_location box_1_location robot_initial_location) 65)

    (= (distance_location robot_initial_location box_2_location) 28)
    (= (distance_location box_2_location robot_initial_location) 28)

    ; Distance b/w robot location and livestock locations
    (= (distance_location robot_initial_location livestock_1_location) 11)
    (= (distance_location livestock_1_location robot_initial_location) 11)

    (= (distance_location robot_initial_location livestock_2_location) 68)
    (= (distance_location livestock_2_location robot_initial_location) 68)

    (= (distance_location robot_initial_location livestock_3_location) 27)
    (= (distance_location livestock_3_location robot_initial_location) 27)

    (= (distance_location robot_initial_location livestock_4_location) 18)
    (= (distance_location livestock_4_location robot_initial_location) 18)

    (= (distance_location robot_initial_location livestock_5_location) 19)
    (= (distance_location livestock_5_location robot_initial_location) 19)

    (= (distance_location robot_initial_location livestock_6_location) 79)
    (= (distance_location livestock_6_location robot_initial_location) 79)

    (= (distance_location robot_initial_location livestock_7_location) 82)
    (= (distance_location livestock_7_location robot_initial_location) 82)

    ; (= (distance_location robot_initial_location robot_2_location) 94)
    ; (= (distance_location robot_2_location robot_initial_location) 94)

    ; Distance b/w robot location and battery recharging station
    (= (distance_location robot_initial_location station_1) 14)
    (= (distance_location station_1 robot_initial_location) 14)

    ; Distance between robot 2 and everything else
    ; (= (distance_location robot_2_location box_1_location) 85)
    ; (= (distance_location box_1_location robot_2_location) 85)

    ; (= (distance_location robot_2_location box_2_location) 32)
    ; (= (distance_location box_2_location robot_2_location) 32)

    ; (= (distance_location robot_2_location livestock_1_location) 28)
    ; (= (distance_location livestock_1_location robot_2_location) 28)

    ; (= (distance_location robot_2_location livestock_2_location) 57)
    ; (= (distance_location livestock_2_location robot_2_location) 57)

    ; (= (distance_location robot_2_location livestock_3_location) 29)
    ; (= (distance_location livestock_3_location robot_2_location) 29)

    ; (= (distance_location robot_2_location livestock_4_location) 63)
    ; (= (distance_location livestock_4_location robot_2_location) 63)

    ; (= (distance_location robot_2_location livestock_5_location) 96)
    ; (= (distance_location livestock_5_location robot_2_location) 96)

    ; (= (distance_location robot_2_location livestock_6_location) 21)
    ; (= (distance_location livestock_6_location robot_2_location) 21)

    ; (= (distance_location robot_2_location livestock_7_location) 75)
    ; (= (distance_location livestock_7_location robot_2_location) 75)

    ; (= (distance_location robot_2_location station_1) 88)
    ; (= (distance_location station_1 robot_2_location) 88)


    ; Distance b/w box 1 location and everything else
    (= (distance_location box_1_location station_1) 53)
    (= (distance_location station_1 box_1_location) 53)

    (= (distance_location box_2_location box_1_location) 24)
    (= (distance_location box_1_location box_2_location) 24)

    (= (distance_location box_1_location livestock_1_location) 76)
    (= (distance_location livestock_1_location box_1_location) 76)

    (= (distance_location box_1_location livestock_2_location) 93)
    (= (distance_location livestock_2_location box_1_location) 93)

    (= (distance_location box_1_location livestock_3_location) 5)
    (= (distance_location livestock_3_location box_1_location) 5)

    (= (distance_location box_1_location livestock_4_location) 48)
    (= (distance_location livestock_4_location box_1_location) 48)

    (= (distance_location box_1_location livestock_5_location) 79)
    (= (distance_location livestock_5_location box_1_location) 79)

    (= (distance_location box_1_location livestock_6_location) 35)
    (= (distance_location livestock_6_location box_1_location) 35)

    (= (distance_location box_1_location livestock_7_location) 25)
    (= (distance_location livestock_7_location box_1_location) 25)

    ; Distance b/w box 2 location and everything else
    (= (distance_location box_2_location station_1) 53)
    (= (distance_location station_1 box_2_location) 53)

    (= (distance_location box_2_location livestock_1_location) 23)
    (= (distance_location livestock_1_location box_2_location) 23)

    (= (distance_location box_2_location livestock_2_location) 66)
    (= (distance_location livestock_2_location box_2_location) 66)

    (= (distance_location box_2_location livestock_3_location) 37)
    (= (distance_location livestock_3_location box_2_location) 37)

    (= (distance_location box_2_location livestock_4_location) 34)
    (= (distance_location livestock_4_location box_2_location) 34)

    (= (distance_location box_2_location livestock_5_location) 15)
    (= (distance_location livestock_5_location box_2_location) 15)

    (= (distance_location box_2_location livestock_6_location) 62)
    (= (distance_location livestock_6_location box_2_location) 62)

    (= (distance_location box_2_location livestock_7_location) 78)
    (= (distance_location livestock_7_location box_2_location) 78)

    (= (distance_location box_2_location station_1) 82)
    (= (distance_location station_1 box_2_location) 82)

    ; Distance b/w station1 and everything else
    (= (distance_location station_1 livestock_1_location) 18)
    (= (distance_location livestock_1_location station_1) 18)

    (= (distance_location station_1 livestock_2_location) 92)
    (= (distance_location livestock_2_location station_1) 92)

    (= (distance_location station_1 livestock_3_location) 55)
    (= (distance_location livestock_3_location station_1) 55)

    (= (distance_location station_1 livestock_4_location) 33)
    (= (distance_location livestock_4_location station_1) 33)

    (= (distance_location station_1 livestock_5_location) 88)
    (= (distance_location livestock_5_location station_1) 88)

    (= (distance_location station_1 livestock_6_location) 37)
    (= (distance_location livestock_6_location station_1) 37)

    (= (distance_location station_1 livestock_7_location) 5)
    (= (distance_location livestock_7_location station_1) 5)

    ; Distance b/w livestock 1 and everything else
    (= (distance_location livestock_1_location livestock_2_location) 33)
    (= (distance_location livestock_2_location livestock_1_location) 33)

    (= (distance_location livestock_1_location livestock_3_location) 77)
    (= (distance_location livestock_3_location livestock_1_location) 77)

    (= (distance_location livestock_1_location livestock_4_location) 34)
    (= (distance_location livestock_4_location livestock_1_location) 34)

    (= (distance_location livestock_1_location livestock_5_location) 64)
    (= (distance_location livestock_5_location livestock_1_location) 64)

    (= (distance_location livestock_1_location livestock_6_location) 75)
    (= (distance_location livestock_6_location livestock_1_location) 75)

    (= (distance_location livestock_1_location livestock_7_location) 36)
    (= (distance_location livestock_7_location livestock_1_location) 36)

    ; Distance b/w livestock 2 and everything else
    (= (distance_location livestock_2_location livestock_3_location) 32)
    (= (distance_location livestock_3_location livestock_2_location) 32)

    (= (distance_location livestock_2_location livestock_4_location) 25)
    (= (distance_location livestock_4_location livestock_2_location) 25)

    (= (distance_location livestock_2_location livestock_5_location) 39)
    (= (distance_location livestock_5_location livestock_2_location) 39)

    (= (distance_location livestock_2_location livestock_6_location) 60)
    (= (distance_location livestock_6_location livestock_2_location) 60)

    (= (distance_location livestock_2_location livestock_7_location) 87)
    (= (distance_location livestock_7_location livestock_2_location) 87)

    ; Distance b/w livestock 3 and everything else
    (= (distance_location livestock_3_location livestock_4_location) 95)
    (= (distance_location livestock_4_location livestock_3_location) 95)

    (= (distance_location livestock_3_location livestock_5_location) 42)
    (= (distance_location livestock_5_location livestock_3_location) 42)

    (= (distance_location livestock_3_location livestock_6_location) 72)
    (= (distance_location livestock_6_location livestock_3_location) 72)

    (= (distance_location livestock_3_location livestock_7_location) 48)
    (= (distance_location livestock_7_location livestock_3_location) 48)

    ; Distance b/w livestock 4 and everything else
    (= (distance_location livestock_4_location livestock_5_location) 43)
    (= (distance_location livestock_5_location livestock_4_location) 43)

    (= (distance_location livestock_4_location livestock_6_location) 22)
    (= (distance_location livestock_6_location livestock_4_location) 22)

    (= (distance_location livestock_4_location livestock_7_location) 4)
    (= (distance_location livestock_7_location livestock_4_location) 4)

    ; Distance b/w livestock 5 and everything else
    (= (distance_location livestock_5_location livestock_6_location) 15)
    (= (distance_location livestock_6_location livestock_5_location) 15)

    (= (distance_location livestock_5_location livestock_7_location) 45)
    (= (distance_location livestock_7_location livestock_5_location) 45)

    ; Distance b/w livestock 6 and 7
    (= (distance_location livestock_6_location livestock_7_location) 15)
    (= (distance_location livestock_7_location livestock_6_location) 15)


    (= (velocity robot_1) 3.63)
    ; (= (velocity robot_2) 4.72)
    (= (velocity robot_3) 5.21)
    (= (velocity robot_4) 4.21)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)
