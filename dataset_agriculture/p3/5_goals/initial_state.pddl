(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base

    robot_1 robot_2 - ground
    robot_3 robot_4 - aerial
    box_1 box_2 - box
    crop_1 crop_2 crop_3 crop_4 crop_5 crop_6 crop_7 crop_8 - crop
    livestock_1 livestock_2 livestock_3 livestock_4 livestock_5 livestock_6 livestock_7 - livestock
    crop_1_location crop_2_location crop_3_location crop_4_location crop_5_location crop_6_location crop_7_location crop_8_location robot_initial_location box_1_location box_2_location livestock_1_location livestock_2_location livestock_3_location livestock_4_location livestock_5_location livestock_6_location livestock_7_location robot_2_location - position
    station_1 - charging-station
    produce_1 produce_2 produce_3 produce_4 produce_5 produce_6 produce_7 - produce

)
(:init
    (aerial_at robot_3 base_1)
    (aerial_at robot_4 base_2)

    (= (battery-amount robot_1) 22)
    (= (battery-amount robot_2) 35)
    (= (battery-amount robot_3) 41)
    (= (battery-amount robot_4) 16)

    (= (input-amount robot_3) 1)
    (= (input-amount robot_4) 2)

    (robot_at robot_1 robot_initial_location)
    (robot_at robot_2 robot_2_location)

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
    (hand-free robot_2)


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
    (= (food-amount robot_2) 1)

    (= (food-capacity) 2)

    (= (water-amount robot_1) 1)
    (= (water-amount robot_2) 1)

    (= (water-capacity) 1)

    (= (discharge-rate-battery) 0.0781)

    (= (battery-capacity) 50)

    (= (input-capacity) 1)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 532)
    (= (distance region_2 region_1) 532)

    (= (distance region_1 region_3) 236)
    (= (distance region_3 region_1) 236)

    (= (distance region_1 region_4) 632)
    (= (distance region_4 region_1) 632)

    (= (distance region_1 region_5) 744)
    (= (distance region_5 region_1) 744)

    (= (distance region_1 region_6) 732)
    (= (distance region_6 region_1) 732)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 421)
    (= (distance region_3 region_2) 421)

    (= (distance region_2 region_4) 222)
    (= (distance region_4 region_2) 222)

    (= (distance region_2 region_5) 383)
    (= (distance region_5 region_2) 383)

    (= (distance region_2 region_6) 463)
    (= (distance region_6 region_2) 463)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 649)
    (= (distance region_4 region_3) 649)

    (= (distance region_3 region_5) 311)
    (= (distance region_5 region_3) 311)

    (= (distance region_3 region_6) 241)
    (= (distance region_6 region_3) 241)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 314)
    (= (distance region_5 region_4) 314)

    (= (distance region_4 region_6) 632)
    (= (distance region_6 region_4) 632)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 123)
    (= (distance region_6 region_5) 123)

    ; Region 2 with bases
    (= (distance base_1 region_2) 35)
    (= (distance region_2 base_1) 35)

    (= (distance base_2 region_2) 632)
    (= (distance region_2 base_2) 632)

    (= (distance base_3 region_2) 853)
    (= (distance region_2 base_3) 853)

    ; Region 1 with bases
    (= (distance base_1 region_1) 235)
    (= (distance region_1 base_1) 235)

    (= (distance base_2 region_1) 636)
    (= (distance region_1 base_2) 636)

    (= (distance base_3 region_1) 663)
    (= (distance region_1 base_3) 663)

    ; Region 5 with bases
    (= (distance base_1 region_5) 773)
    (= (distance region_5 base_1) 773)

    (= (distance base_2 region_5) 235)
    (= (distance region_5 base_2) 235)

    (= (distance base_3 region_5) 763)
    (= (distance region_5 base_3) 763)

    ; Region 6 with bases
    (= (distance base_1 region_6) 135)
    (= (distance region_6 base_1) 135)

    (= (distance base_2 region_6) 523)
    (= (distance region_6 base_2) 523)

    (= (distance base_3 region_6) 772)
    (= (distance region_6 base_3) 772)

    ; Region 3 with bases
    (= (distance base_1 region_3) 146)
    (= (distance region_3 base_1) 146)

    (= (distance base_2 region_3) 882)
    (= (distance region_3 base_2) 882)

    (= (distance base_3 region_3) 262)
    (= (distance region_3 base_3) 262)

    ; Region 4 with bases
    (= (distance base_1 region_4) 546)
    (= (distance region_4 base_1) 546)

    (= (distance base_2 region_4) 258)
    (= (distance region_4 base_2) 258)

    (= (distance base_3 region_4) 436)
    (= (distance region_4 base_3) 436)

    ; Base distance with one another
    (= (distance base_1 base_2) 362)
    (= (distance base_2 base_1) 362)

    (= (distance base_1 base_3) 235)
    (= (distance base_3 base_1) 235)

    (= (distance base_2 base_3) 637)
    (= (distance base_3 base_2) 637)




   ; Distance between crop 1 and everthing else
    (= (distance_location crop_1_location crop_2_location) 52)
    (= (distance_location crop_2_location crop_1_location) 52)

    (= (distance_location crop_1_location crop_3_location) 63)
    (= (distance_location crop_3_location crop_1_location) 63)

    (= (distance_location crop_1_location crop_4_location) 25)
    (= (distance_location crop_4_location crop_1_location) 25)

    (= (distance_location crop_1_location crop_5_location) 63)
    (= (distance_location crop_5_location crop_1_location) 63)

    (= (distance_location crop_1_location crop_6_location) 74)
    (= (distance_location crop_6_location crop_1_location) 74)

    (= (distance_location crop_1_location crop_7_location) 82)
    (= (distance_location crop_7_location crop_1_location) 82)

    (= (distance_location crop_1_location crop_8_location) 61)
    (= (distance_location crop_8_location crop_1_location) 61)

    (= (distance_location crop_1_location robot_initial_location) 22)
    (= (distance_location robot_initial_location crop_1_location) 22)
    
    (= (distance_location crop_1_location box_1_location) 79)
    (= (distance_location box_1_location crop_1_location) 79)

    (= (distance_location crop_1_location box_2_location) 5)
    (= (distance_location box_2_location crop_1_location) 5)

    (= (distance_location crop_1_location station_1) 29)
    (= (distance_location station_1 crop_1_location) 29)

    (= (distance_location crop_1_location livestock_1_location) 47)
    (= (distance_location livestock_1_location crop_1_location) 47)

    (= (distance_location crop_1_location livestock_2_location) 86)
    (= (distance_location livestock_2_location crop_1_location) 86)

    (= (distance_location crop_1_location livestock_3_location) 18)
    (= (distance_location livestock_3_location crop_1_location) 18)

    (= (distance_location crop_1_location livestock_4_location) 99)
    (= (distance_location livestock_4_location crop_1_location) 99)

    (= (distance_location crop_1_location livestock_5_location) 47)
    (= (distance_location livestock_5_location crop_1_location) 47)

    (= (distance_location crop_1_location livestock_6_location) 81)
    (= (distance_location livestock_6_location crop_1_location) 81)

    (= (distance_location crop_1_location livestock_7_location) 27)
    (= (distance_location livestock_7_location crop_1_location) 27)

    (= (distance_location crop_1_location robot_2_location) 54)
    (= (distance_location robot_2_location crop_1_location) 54)

    ; Distance of crop 2 with everything else
    (= (distance_location crop_2_location crop_3_location) 73)
    (= (distance_location crop_3_location crop_2_location) 73)

    (= (distance_location crop_2_location crop_4_location) 27)
    (= (distance_location crop_4_location crop_2_location) 27)

    (= (distance_location crop_2_location crop_5_location) 48)
    (= (distance_location crop_5_location crop_2_location) 48)
    
    (= (distance_location crop_2_location crop_6_location) 6)
    (= (distance_location crop_6_location crop_2_location) 6)

    (= (distance_location crop_2_location crop_7_location) 86)
    (= (distance_location crop_7_location crop_2_location) 86)

    (= (distance_location crop_2_location crop_8_location) 17)
    (= (distance_location crop_8_location crop_2_location) 17)

    (= (distance_location crop_2_location robot_initial_location) 95)
    (= (distance_location robot_initial_location crop_2_location) 95)
    
    (= (distance_location crop_2_location box_1_location) 54)
    (= (distance_location box_1_location crop_2_location) 54)

    (= (distance_location crop_2_location box_2_location) 82)
    (= (distance_location box_2_location crop_2_location) 82)

    (= (distance_location crop_2_location station_1) 44)
    (= (distance_location station_1 crop_2_location) 44)

    (= (distance_location crop_2_location livestock_1_location) 14)
    (= (distance_location livestock_1_location crop_2_location) 14)

    (= (distance_location crop_2_location livestock_2_location) 66)
    (= (distance_location livestock_2_location crop_2_location) 66)

    (= (distance_location crop_2_location livestock_3_location) 77)
    (= (distance_location livestock_3_location crop_2_location) 77)

    (= (distance_location crop_2_location livestock_4_location) 39)
    (= (distance_location livestock_4_location crop_2_location) 39)

    (= (distance_location crop_2_location livestock_5_location) 74)
    (= (distance_location livestock_5_location crop_2_location) 74)

    (= (distance_location crop_2_location livestock_6_location) 19)
    (= (distance_location livestock_6_location crop_2_location) 19)

    (= (distance_location crop_2_location livestock_7_location) 41)
    (= (distance_location livestock_7_location crop_2_location) 41)

    (= (distance_location crop_2_location robot_2_location) 23)
    (= (distance_location robot_2_location crop_2_location) 23)

    
    ; Distance of crop 3 with everything else
    (= (distance_location crop_3_location crop_4_location) 97)
    (= (distance_location crop_4_location crop_3_location) 97)

    (= (distance_location crop_3_location crop_5_location) 37)
    (= (distance_location crop_5_location crop_3_location) 37)

    (= (distance_location crop_3_location crop_6_location) 19)
    (= (distance_location crop_6_location crop_3_location) 19)

    (= (distance_location crop_3_location crop_7_location) 7)
    (= (distance_location crop_7_location crop_3_location) 7)

    (= (distance_location crop_3_location crop_8_location) 85)
    (= (distance_location crop_8_location crop_3_location) 85)
    
    (= (distance_location crop_3_location robot_initial_location) 93)
    (= (distance_location robot_initial_location crop_3_location) 93)
    
    (= (distance_location crop_3_location box_1_location) 47)
    (= (distance_location box_1_location crop_3_location) 47)

    (= (distance_location crop_3_location box_2_location) 52)
    (= (distance_location box_2_location crop_3_location) 52)

    (= (distance_location crop_3_location station_1) 24)
    (= (distance_location station_1 crop_3_location) 24)

    (= (distance_location crop_3_location livestock_1_location) 83)
    (= (distance_location livestock_1_location crop_3_location) 83)

    (= (distance_location crop_3_location livestock_2_location) 11)
    (= (distance_location livestock_2_location crop_3_location) 11)

    (= (distance_location crop_3_location livestock_3_location) 52)
    (= (distance_location livestock_3_location crop_3_location) 52)

    (= (distance_location crop_3_location livestock_4_location) 65)
    (= (distance_location livestock_4_location crop_3_location) 65)

    (= (distance_location crop_3_location livestock_5_location) 35)
    (= (distance_location livestock_5_location crop_3_location) 35)

    (= (distance_location crop_3_location livestock_6_location) 85)
    (= (distance_location livestock_6_location crop_3_location) 85)

    (= (distance_location crop_3_location livestock_7_location) 95)
    (= (distance_location livestock_7_location crop_3_location) 95)

    (= (distance_location crop_3_location robot_2_location) 39)
    (= (distance_location robot_2_location crop_3_location) 39)

    ; Distance of crop 4 with everything else
    (= (distance_location crop_4_location crop_5_location) 38)
    (= (distance_location crop_5_location crop_4_location) 38)
    
    (= (distance_location crop_4_location crop_6_location) 75)
    (= (distance_location crop_6_location crop_4_location) 75)

    (= (distance_location crop_4_location crop_7_location) 28)
    (= (distance_location crop_7_location crop_4_location) 28)

    (= (distance_location crop_4_location crop_8_location) 83)
    (= (distance_location crop_8_location crop_4_location) 83)
    
    (= (distance_location crop_4_location robot_initial_location) 72)
    (= (distance_location robot_initial_location crop_4_location) 72)
    
    (= (distance_location crop_4_location box_1_location) 88)
    (= (distance_location box_1_location crop_4_location) 88)

    (= (distance_location crop_4_location box_2_location) 49)
    (= (distance_location box_2_location crop_4_location) 49)

    (= (distance_location crop_4_location station_1) 22)
    (= (distance_location station_1 crop_4_location) 22)

    (= (distance_location crop_4_location livestock_1_location) 72)
    (= (distance_location livestock_1_location crop_4_location) 72)

    (= (distance_location crop_4_location livestock_2_location) 17)
    (= (distance_location livestock_2_location crop_4_location) 17)

    (= (distance_location crop_4_location livestock_3_location) 85)
    (= (distance_location livestock_3_location crop_4_location) 85)

    (= (distance_location crop_4_location livestock_4_location) 69)
    (= (distance_location livestock_4_location crop_4_location) 69)

    (= (distance_location crop_4_location livestock_5_location) 36)
    (= (distance_location livestock_5_location crop_4_location) 36)

    (= (distance_location crop_4_location livestock_6_location) 84)
    (= (distance_location livestock_6_location crop_4_location) 84)

    (= (distance_location crop_4_location livestock_7_location) 74)
    (= (distance_location livestock_7_location crop_4_location) 74)

    (= (distance_location crop_4_location robot_2_location) 41)
    (= (distance_location robot_2_location crop_4_location) 41)

    ; Distance of crop 5 with everything else
    (= (distance_location crop_5_location crop_6_location) 38)
    (= (distance_location crop_6_location crop_5_location) 38)

    (= (distance_location crop_5_location crop_7_location) 85)
    (= (distance_location crop_7_location crop_5_location) 85)

    (= (distance_location crop_5_location crop_8_location) 13)
    (= (distance_location crop_8_location crop_5_location) 13)

    (= (distance_location crop_5_location robot_initial_location) 88)
    (= (distance_location robot_initial_location crop_5_location) 88)
    
    (= (distance_location crop_5_location box_1_location) 47)
    (= (distance_location box_1_location crop_5_location) 47)

    (= (distance_location crop_5_location box_2_location) 39)
    (= (distance_location box_2_location crop_5_location) 39)

    (= (distance_location crop_5_location station_1) 38)
    (= (distance_location station_1 crop_5_location) 38)

    (= (distance_location crop_5_location livestock_1_location) 84)
    (= (distance_location livestock_1_location crop_5_location) 84)

    (= (distance_location crop_5_location livestock_2_location) 93)
    (= (distance_location livestock_2_location crop_5_location) 93)

    (= (distance_location crop_5_location livestock_3_location) 14)
    (= (distance_location livestock_3_location crop_5_location) 14)

    (= (distance_location crop_5_location livestock_4_location) 85)
    (= (distance_location livestock_4_location crop_5_location) 85)

    (= (distance_location crop_5_location livestock_5_location) 96)
    (= (distance_location livestock_5_location crop_5_location) 96)

    (= (distance_location crop_5_location livestock_6_location) 47)
    (= (distance_location livestock_6_location crop_5_location) 47)

    (= (distance_location crop_5_location livestock_7_location) 85)
    (= (distance_location livestock_7_location crop_5_location) 85)

    (= (distance_location crop_5_location robot_2_location) 43)
    (= (distance_location robot_2_location crop_5_location) 43)

    ; Distance of crop 6 with everything else
    (= (distance_location crop_6_location crop_7_location) 26)
    (= (distance_location crop_7_location crop_6_location) 26)

    (= (distance_location crop_6_location crop_8_location) 74)
    (= (distance_location crop_8_location crop_6_location) 74)

    (= (distance_location crop_6_location robot_initial_location) 71)
    (= (distance_location robot_initial_location crop_6_location) 71)
    
    (= (distance_location crop_6_location box_1_location) 78)
    (= (distance_location box_1_location crop_6_location) 78)

    (= (distance_location crop_6_location box_2_location) 21)
    (= (distance_location box_2_location crop_6_location) 21)

    (= (distance_location crop_6_location station_1) 45)
    (= (distance_location station_1 crop_6_location) 45)

    (= (distance_location crop_6_location livestock_1_location) 85)
    (= (distance_location livestock_1_location crop_6_location) 85)

    (= (distance_location crop_6_location livestock_2_location) 38)
    (= (distance_location livestock_2_location crop_6_location) 38)

    (= (distance_location crop_6_location livestock_3_location) 82)
    (= (distance_location livestock_3_location crop_6_location) 82)

    (= (distance_location crop_6_location livestock_4_location) 46)
    (= (distance_location livestock_4_location crop_6_location) 46)

    (= (distance_location crop_6_location livestock_5_location) 82)
    (= (distance_location livestock_5_location crop_6_location) 82)

    (= (distance_location crop_6_location livestock_6_location) 74)
    (= (distance_location livestock_6_location crop_6_location) 74)

    (= (distance_location crop_6_location livestock_7_location) 26)
    (= (distance_location livestock_7_location crop_6_location) 26)

    (= (distance_location crop_6_location robot_2_location) 18)
    (= (distance_location robot_2_location crop_6_location) 18)

    ; Distance of crop 7 with everything else
    (= (distance_location crop_7_location crop_8_location) 89)
    (= (distance_location crop_8_location crop_7_location) 89)

    (= (distance_location crop_7_location robot_initial_location) 24)
    (= (distance_location robot_initial_location crop_7_location) 24)
    
    (= (distance_location crop_7_location box_1_location) 74)
    (= (distance_location box_1_location crop_7_location) 74)

    (= (distance_location crop_7_location box_2_location) 68)
    (= (distance_location box_2_location crop_7_location) 68)

    (= (distance_location crop_7_location station_1) 36)
    (= (distance_location station_1 crop_7_location) 36)

    (= (distance_location crop_7_location livestock_1_location) 77)
    (= (distance_location livestock_1_location crop_7_location) 77)

    (= (distance_location crop_7_location livestock_2_location) 35)
    (= (distance_location livestock_2_location crop_7_location) 35)

    (= (distance_location crop_7_location livestock_3_location) 82)
    (= (distance_location livestock_3_location crop_7_location) 82)

    (= (distance_location crop_7_location livestock_4_location) 36)
    (= (distance_location livestock_4_location crop_7_location) 36)

    (= (distance_location crop_7_location livestock_5_location) 84)
    (= (distance_location livestock_5_location crop_7_location) 84)

    (= (distance_location crop_7_location livestock_6_location) 92)
    (= (distance_location livestock_6_location crop_7_location) 92)

    (= (distance_location crop_7_location livestock_7_location) 47)
    (= (distance_location livestock_7_location crop_7_location) 47)

    (= (distance_location crop_7_location robot_2_location) 61)
    (= (distance_location robot_2_location crop_7_location) 61)

    ; Distance of crop 8 with everything else
    (= (distance_location crop_8_location robot_initial_location) 22)
    (= (distance_location robot_initial_location crop_8_location) 22)
    
    (= (distance_location crop_8_location box_1_location) 73)
    (= (distance_location box_1_location crop_8_location) 73)

    (= (distance_location crop_8_location box_2_location) 53)
    (= (distance_location box_2_location crop_8_location) 53)

    (= (distance_location crop_8_location station_1) 11)
    (= (distance_location station_1 crop_8_location) 11)

    (= (distance_location crop_8_location livestock_1_location) 18)
    (= (distance_location livestock_1_location crop_8_location) 18)

    (= (distance_location crop_8_location livestock_2_location) 84)
    (= (distance_location livestock_2_location crop_8_location) 84)

    (= (distance_location crop_8_location livestock_3_location) 36)
    (= (distance_location livestock_3_location crop_8_location) 36)

    (= (distance_location crop_8_location livestock_4_location) 43)
    (= (distance_location livestock_4_location crop_8_location) 43)

    (= (distance_location crop_8_location livestock_5_location) 88)
    (= (distance_location livestock_5_location crop_8_location) 88)

    (= (distance_location crop_8_location livestock_6_location) 28)
    (= (distance_location livestock_6_location crop_8_location) 28)

    (= (distance_location crop_8_location livestock_7_location) 27)
    (= (distance_location livestock_7_location crop_8_location) 27)

    (= (distance_location crop_8_location robot_2_location) 11)
    (= (distance_location robot_2_location crop_8_location) 11)

    ; Distance between box and robot location
    (= (distance_location robot_initial_location box_1_location) 35)
    (= (distance_location box_1_location robot_initial_location) 35)

    (= (distance_location robot_initial_location box_2_location) 38)
    (= (distance_location box_2_location robot_initial_location) 38)

    ; Distance b/w robot location and livestock locations
    (= (distance_location robot_initial_location livestock_1_location) 11)
    (= (distance_location livestock_1_location robot_initial_location) 11)

    (= (distance_location robot_initial_location livestock_2_location) 18)
    (= (distance_location livestock_2_location robot_initial_location) 18)

    (= (distance_location robot_initial_location livestock_3_location) 47)
    (= (distance_location livestock_3_location robot_initial_location) 47)

    (= (distance_location robot_initial_location livestock_4_location) 28)
    (= (distance_location livestock_4_location robot_initial_location) 28)

    (= (distance_location robot_initial_location livestock_5_location) 59)
    (= (distance_location livestock_5_location robot_initial_location) 59)

    (= (distance_location robot_initial_location livestock_6_location) 29)
    (= (distance_location livestock_6_location robot_initial_location) 29)

    (= (distance_location robot_initial_location livestock_7_location) 82)
    (= (distance_location livestock_7_location robot_initial_location) 82)

    (= (distance_location robot_initial_location robot_2_location) 26)
    (= (distance_location robot_2_location robot_initial_location) 26)

    ; Distance b/w robot location and battery recharging station
    (= (distance_location robot_initial_location station_1) 34)
    (= (distance_location station_1 robot_initial_location) 34)

    ; Distance between robot 2 and everything else
    (= (distance_location robot_2_location box_1_location) 35)
    (= (distance_location box_1_location robot_2_location) 35)

    (= (distance_location robot_2_location box_2_location) 32)
    (= (distance_location box_2_location robot_2_location) 32)

    (= (distance_location robot_2_location livestock_1_location) 28)
    (= (distance_location livestock_1_location robot_2_location) 28)

    (= (distance_location robot_2_location livestock_2_location) 57)
    (= (distance_location livestock_2_location robot_2_location) 57)

    (= (distance_location robot_2_location livestock_3_location) 29)
    (= (distance_location livestock_3_location robot_2_location) 29)

    (= (distance_location robot_2_location livestock_4_location) 63)
    (= (distance_location livestock_4_location robot_2_location) 63)

    (= (distance_location robot_2_location livestock_5_location) 42)
    (= (distance_location livestock_5_location robot_2_location) 42)

    (= (distance_location robot_2_location livestock_6_location) 21)
    (= (distance_location livestock_6_location robot_2_location) 21)

    (= (distance_location robot_2_location livestock_7_location) 33)
    (= (distance_location livestock_7_location robot_2_location) 33)

    (= (distance_location robot_2_location station_1) 12)
    (= (distance_location station_1 robot_2_location) 12)


    ; Distance b/w box 1 location and everything else
    (= (distance_location box_1_location station_1) 23)
    (= (distance_location station_1 box_1_location) 23)

    (= (distance_location box_2_location box_1_location) 34)
    (= (distance_location box_1_location box_2_location) 34)

    (= (distance_location box_1_location livestock_1_location) 46)
    (= (distance_location livestock_1_location box_1_location) 46)

    (= (distance_location box_1_location livestock_2_location) 33)
    (= (distance_location livestock_2_location box_1_location) 33)

    (= (distance_location box_1_location livestock_3_location) 55)
    (= (distance_location livestock_3_location box_1_location) 55)

    (= (distance_location box_1_location livestock_4_location) 38)
    (= (distance_location livestock_4_location box_1_location) 38)

    (= (distance_location box_1_location livestock_5_location) 25)
    (= (distance_location livestock_5_location box_1_location) 25)

    (= (distance_location box_1_location livestock_6_location) 35)
    (= (distance_location livestock_6_location box_1_location) 35)

    (= (distance_location box_1_location livestock_7_location) 25)
    (= (distance_location livestock_7_location box_1_location) 25)

    ; Distance b/w box 2 location and everything else
    (= (distance_location box_2_location station_1) 33)
    (= (distance_location station_1 box_2_location) 33)

    (= (distance_location box_2_location livestock_1_location) 13)
    (= (distance_location livestock_1_location box_2_location) 13)

    (= (distance_location box_2_location livestock_2_location) 36)
    (= (distance_location livestock_2_location box_2_location) 36)

    (= (distance_location box_2_location livestock_3_location) 44)
    (= (distance_location livestock_3_location box_2_location) 44)

    (= (distance_location box_2_location livestock_4_location) 14)
    (= (distance_location livestock_4_location box_2_location) 14)

    (= (distance_location box_2_location livestock_5_location) 35)
    (= (distance_location livestock_5_location box_2_location) 35)

    (= (distance_location box_2_location livestock_6_location) 32)
    (= (distance_location livestock_6_location box_2_location) 32)

    (= (distance_location box_2_location livestock_7_location) 48)
    (= (distance_location livestock_7_location box_2_location) 48)

    (= (distance_location box_2_location station_1) 22)
    (= (distance_location station_1 box_2_location) 22)

    ; Distance b/w station1 and everything else
    (= (distance_location station_1 livestock_1_location) 18)
    (= (distance_location livestock_1_location station_1) 18)

    (= (distance_location station_1 livestock_2_location) 22)
    (= (distance_location livestock_2_location station_1) 22)

    (= (distance_location station_1 livestock_3_location) 75)
    (= (distance_location livestock_3_location station_1) 75)

    (= (distance_location station_1 livestock_4_location) 23)
    (= (distance_location livestock_4_location station_1) 23)

    (= (distance_location station_1 livestock_5_location) 78)
    (= (distance_location livestock_5_location station_1) 78)

    (= (distance_location station_1 livestock_6_location) 57)
    (= (distance_location livestock_6_location station_1) 57)

    (= (distance_location station_1 livestock_7_location) 18)
    (= (distance_location livestock_7_location station_1) 18)

    ; Distance b/w livestock 1 and everything else
    (= (distance_location livestock_1_location livestock_2_location) 5)
    (= (distance_location livestock_2_location livestock_1_location) 5)

    (= (distance_location livestock_1_location livestock_3_location) 27)
    (= (distance_location livestock_3_location livestock_1_location) 27)

    (= (distance_location livestock_1_location livestock_4_location) 84)
    (= (distance_location livestock_4_location livestock_1_location) 84)

    (= (distance_location livestock_1_location livestock_5_location) 34)
    (= (distance_location livestock_5_location livestock_1_location) 34)

    (= (distance_location livestock_1_location livestock_6_location) 85)
    (= (distance_location livestock_6_location livestock_1_location) 85)

    (= (distance_location livestock_1_location livestock_7_location) 66)
    (= (distance_location livestock_7_location livestock_1_location) 66)

    ; Distance b/w livestock 2 and everything else
    (= (distance_location livestock_2_location livestock_3_location) 22)
    (= (distance_location livestock_3_location livestock_2_location) 22)

    (= (distance_location livestock_2_location livestock_4_location) 85)
    (= (distance_location livestock_4_location livestock_2_location) 85)

    (= (distance_location livestock_2_location livestock_5_location) 79)
    (= (distance_location livestock_5_location livestock_2_location) 79)

    (= (distance_location livestock_2_location livestock_6_location) 90)
    (= (distance_location livestock_6_location livestock_2_location) 90)

    (= (distance_location livestock_2_location livestock_7_location) 47)
    (= (distance_location livestock_7_location livestock_2_location) 47)

    ; Distance b/w livestock 3 and everything else
    (= (distance_location livestock_3_location livestock_4_location) 35)
    (= (distance_location livestock_4_location livestock_3_location) 35)

    (= (distance_location livestock_3_location livestock_5_location) 72)
    (= (distance_location livestock_5_location livestock_3_location) 72)

    (= (distance_location livestock_3_location livestock_6_location) 42)
    (= (distance_location livestock_6_location livestock_3_location) 42)

    (= (distance_location livestock_3_location livestock_7_location) 28)
    (= (distance_location livestock_7_location livestock_3_location) 28)

    ; Distance b/w livestock 4 and everything else
    (= (distance_location livestock_4_location livestock_5_location) 73)
    (= (distance_location livestock_5_location livestock_4_location) 73)

    (= (distance_location livestock_4_location livestock_6_location) 62)
    (= (distance_location livestock_6_location livestock_4_location) 62)

    (= (distance_location livestock_4_location livestock_7_location) 4)
    (= (distance_location livestock_7_location livestock_4_location) 4)

    ; Distance b/w livestock 5 and everything else
    (= (distance_location livestock_5_location livestock_6_location) 65)
    (= (distance_location livestock_6_location livestock_5_location) 65)

    (= (distance_location livestock_5_location livestock_7_location) 95)
    (= (distance_location livestock_7_location livestock_5_location) 95)

    ; Distance b/w livestock 6 and 7
    (= (distance_location livestock_6_location livestock_7_location) 65)
    (= (distance_location livestock_7_location livestock_6_location) 65)


    (= (velocity robot_1) 1.66)
    (= (velocity robot_2) 1.62)
    (= (velocity robot_3) 2.04)
    (= (velocity robot_4) 5.27)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)
