(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base

    robot_1 robot_2 - ground
    robot_3 robot_4 - aerial
    box_1 box_2 - box
    crop_1 crop_2 crop_3 crop_4 crop_5 - crop
    livestock_1 livestock_2 livestock_3 livestock_4 livestock_5 livestock_6 livestock_7 - livestock
    crop_1_location crop_2_location crop_3_location crop_4_location crop_5_location robot_initial_location box_1_location box_2_location livestock_1_location livestock_2_location livestock_3_location livestock_4_location livestock_5_location livestock_6_location livestock_7_location robot_2_location - position
    station_1 - charging-station
    produce_1 produce_2 produce_3 produce_4 produce_5 produce_6 produce_7 - produce

)
(:init
    (at robot_3 base_1)
    (at robot_4 base_3)

    (= (battery-amount robot_1) 53)
    (= (battery-amount robot_2) 24)
    (= (battery-amount robot_3) 62)
    (= (battery-amount robot_4) 51)

    ; (= (input-amount robot_1) 1)
    (= (input-amount robot_3) 0)
    (= (input-amount robot_4) 2)

    (robot_at robot_1 robot_initial_location)
    (robot_at robot_2 robot_2_location)

    (crop_at crop_1 crop_1_location)
    (crop_at crop_2 crop_2_location)
    (crop_at crop_3 crop_3_location)
    (crop_at crop_4 crop_4_location)
    (crop_at crop_5 crop_5_location)

    (box_at box_1 box_1_location)
    (box_at box_2 box_2_location)

    (crop-ripe crop_1 crop_1_location)
    (crop-ripe crop_2 crop_2_location)
    (crop-ripe crop_3 crop_3_location)
    (crop-ripe crop_4 crop_4_location)
    (crop-ripe crop_5 crop_5_location)

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

    (= (food-amount robot_1) 1)
    (= (food-amount robot_2) 1)

    (= (food-capacity) 1)

    (= (water-amount robot_1) 0)
    (= (water-amount robot_2) 1)

    (= (water-capacity) 1)

    (= (discharge-rate-battery) 0.0281)

    (= (battery-capacity) 185)

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




   ; Distance between crop 1 and everthing else
    (= (distance_location crop_1_location crop_2_location) 41)
    (= (distance_location crop_2_location crop_1_location) 41)

    (= (distance_location crop_1_location crop_3_location) 33)
    (= (distance_location crop_3_location crop_1_location) 33)

    (= (distance_location crop_1_location crop_4_location) 18)
    (= (distance_location crop_4_location crop_1_location) 18)

    (= (distance_location crop_1_location crop_5_location) 11)
    (= (distance_location crop_5_location crop_1_location) 11)

    (= (distance_location crop_1_location robot_initial_location) 19)
    (= (distance_location robot_initial_location crop_1_location) 10)
    
    (= (distance_location crop_1_location box_1_location) 63)
    (= (distance_location box_1_location crop_1_location) 63)

    (= (distance_location crop_1_location box_2_location) 51)
    (= (distance_location box_2_location crop_1_location) 51)

    (= (distance_location crop_1_location station_1) 38)
    (= (distance_location station_1 crop_1_location) 38)

    (= (distance_location crop_1_location livestock_1_location) 20)
    (= (distance_location livestock_1_location crop_1_location) 20)

    (= (distance_location crop_1_location livestock_2_location) 14)
    (= (distance_location livestock_2_location crop_1_location) 14)

    (= (distance_location crop_1_location livestock_3_location) 82)
    (= (distance_location livestock_3_location crop_1_location) 82)

    (= (distance_location crop_1_location livestock_4_location) 59)
    (= (distance_location livestock_4_location crop_1_location) 59)

    (= (distance_location crop_1_location livestock_5_location) 47)
    (= (distance_location livestock_5_location crop_1_location) 47)

    (= (distance_location crop_1_location livestock_6_location) 72)
    (= (distance_location livestock_6_location crop_1_location) 72)

    (= (distance_location crop_1_location livestock_7_location) 36)
    (= (distance_location livestock_7_location crop_1_location) 36)

    (= (distance_location crop_1_location robot_2_location) 24)
    (= (distance_location robot_2_location crop_1_location) 24)

    ; Distance of crop 2 with everything else
    (= (distance_location crop_2_location crop_3_location) 62)
    (= (distance_location crop_3_location crop_2_location) 62)

    (= (distance_location crop_2_location crop_4_location) 70)
    (= (distance_location crop_4_location crop_2_location) 70)

    (= (distance_location crop_2_location crop_5_location) 21)
    (= (distance_location crop_5_location crop_2_location) 21)

    (= (distance_location crop_2_location robot_initial_location) 41)
    (= (distance_location robot_initial_location crop_2_location) 41)
    
    (= (distance_location crop_2_location box_1_location) 50)
    (= (distance_location box_1_location crop_2_location) 50)

    (= (distance_location crop_2_location box_2_location) 44)
    (= (distance_location box_2_location crop_2_location) 44)

    (= (distance_location crop_2_location station_1) 28)
    (= (distance_location station_1 crop_2_location) 28)

    (= (distance_location crop_2_location livestock_1_location) 41)
    (= (distance_location livestock_1_location crop_2_location) 41)

    (= (distance_location crop_2_location livestock_2_location) 62)
    (= (distance_location livestock_2_location crop_2_location) 62)

    (= (distance_location crop_2_location livestock_3_location) 71)
    (= (distance_location livestock_3_location crop_2_location) 71)

    (= (distance_location crop_2_location livestock_4_location) 18)
    (= (distance_location livestock_4_location crop_2_location) 18)

    (= (distance_location crop_2_location livestock_5_location) 94)
    (= (distance_location livestock_5_location crop_2_location) 94)

    (= (distance_location crop_2_location livestock_6_location) 62)
    (= (distance_location livestock_6_location crop_2_location) 62)

    (= (distance_location crop_2_location livestock_7_location) 27)
    (= (distance_location livestock_7_location crop_2_location) 27)

    (= (distance_location crop_2_location robot_2_location) 50)
    (= (distance_location robot_2_location crop_2_location) 50)

    
    ; Distance of crop 3 with everything else
    (= (distance_location crop_3_location crop_4_location) 42)
    (= (distance_location crop_4_location crop_3_location) 42)

    (= (distance_location crop_3_location crop_5_location) 52)
    (= (distance_location crop_5_location crop_3_location) 52)
    
    (= (distance_location crop_3_location robot_initial_location) 68)
    (= (distance_location robot_initial_location crop_3_location) 68)
    
    (= (distance_location crop_3_location box_1_location) 42)
    (= (distance_location box_1_location crop_3_location) 42)

    (= (distance_location crop_3_location box_2_location) 75)
    (= (distance_location box_2_location crop_3_location) 75)

    (= (distance_location crop_3_location station_1) 2)
    (= (distance_location station_1 crop_3_location) 2)

    (= (distance_location crop_3_location livestock_1_location) 64)
    (= (distance_location livestock_1_location crop_3_location) 64)

    (= (distance_location crop_3_location livestock_2_location) 15)
    (= (distance_location livestock_2_location crop_3_location) 15)

    (= (distance_location crop_3_location livestock_3_location) 57)
    (= (distance_location livestock_3_location crop_3_location) 57)

    (= (distance_location crop_3_location livestock_4_location) 9)
    (= (distance_location livestock_4_location crop_3_location) 9)

    (= (distance_location crop_3_location livestock_5_location) 23)
    (= (distance_location livestock_5_location crop_3_location) 23)

    (= (distance_location crop_3_location livestock_6_location) 25)
    (= (distance_location livestock_6_location crop_3_location) 25)

    (= (distance_location crop_3_location livestock_7_location) 64)
    (= (distance_location livestock_7_location crop_3_location) 64)

    (= (distance_location crop_3_location robot_2_location) 67)
    (= (distance_location robot_2_location crop_3_location) 67)

    ; Distance of crop 4 with everything else
    (= (distance_location crop_4_location crop_5_location) 4)
    (= (distance_location crop_5_location crop_4_location) 4)
    
    (= (distance_location crop_4_location robot_initial_location) 94)
    (= (distance_location robot_initial_location crop_4_location) 94)
    
    (= (distance_location crop_4_location box_1_location) 24)
    (= (distance_location box_1_location crop_4_location) 24)

    (= (distance_location crop_4_location box_2_location) 53)
    (= (distance_location box_2_location crop_4_location) 53)

    (= (distance_location crop_4_location station_1) 68)
    (= (distance_location station_1 crop_4_location) 68)

    (= (distance_location crop_4_location livestock_1_location) 32)
    (= (distance_location livestock_1_location crop_4_location) 32)

    (= (distance_location crop_4_location livestock_2_location) 9)
    (= (distance_location livestock_2_location crop_4_location) 9)

    (= (distance_location crop_4_location livestock_3_location) 22)
    (= (distance_location livestock_3_location crop_4_location) 22)

    (= (distance_location crop_4_location livestock_4_location) 6)
    (= (distance_location livestock_4_location crop_4_location) 6)

    (= (distance_location crop_4_location livestock_5_location) 94)
    (= (distance_location livestock_5_location crop_4_location) 94)

    (= (distance_location crop_4_location livestock_6_location) 84)
    (= (distance_location livestock_6_location crop_4_location) 84)

    (= (distance_location crop_4_location livestock_7_location) 23)
    (= (distance_location livestock_7_location crop_4_location) 23)

    (= (distance_location crop_4_location robot_2_location) 63)
    (= (distance_location robot_2_location crop_4_location) 63)

    ; Distance of crop 5 with everything else    
    (= (distance_location crop_5_location robot_initial_location) 54)
    (= (distance_location robot_initial_location crop_5_location) 54)
    
    (= (distance_location crop_5_location box_1_location) 66)
    (= (distance_location box_1_location crop_5_location) 66)

    (= (distance_location crop_5_location box_2_location) 27)
    (= (distance_location box_2_location crop_5_location) 27)

    (= (distance_location crop_5_location station_1) 84)
    (= (distance_location station_1 crop_5_location) 84)

    (= (distance_location crop_5_location livestock_1_location) 51)
    (= (distance_location livestock_1_location crop_5_location) 51)

    (= (distance_location crop_5_location livestock_2_location) 67)
    (= (distance_location livestock_2_location crop_5_location) 67)

    (= (distance_location crop_5_location livestock_3_location) 30)
    (= (distance_location livestock_3_location crop_5_location) 30)

    (= (distance_location crop_5_location livestock_4_location) 74)
    (= (distance_location livestock_4_location crop_5_location) 74)

    (= (distance_location crop_5_location livestock_5_location) 43)
    (= (distance_location livestock_5_location crop_5_location) 43)

    (= (distance_location crop_5_location livestock_6_location) 6)
    (= (distance_location livestock_6_location crop_5_location) 6)

    (= (distance_location crop_5_location livestock_7_location) 16)
    (= (distance_location livestock_7_location crop_5_location) 16)

    (= (distance_location crop_5_location robot_2_location) 45)
    (= (distance_location robot_2_location crop_5_location) 45)

    ; Distance between box and robot location
    (= (distance_location robot_initial_location box_1_location) 64)
    (= (distance_location box_1_location robot_initial_location) 64)

    (= (distance_location robot_initial_location box_2_location) 99)
    (= (distance_location box_2_location robot_initial_location) 99)

    ; Distance b/w robot location and livestock locations
    (= (distance_location robot_initial_location livestock_1_location) 33)
    (= (distance_location livestock_1_location robot_initial_location) 33)

    (= (distance_location robot_initial_location livestock_2_location) 55)
    (= (distance_location livestock_2_location robot_initial_location) 55)

    (= (distance_location robot_initial_location livestock_3_location) 26)
    (= (distance_location livestock_3_location robot_initial_location) 26)

    (= (distance_location robot_initial_location livestock_4_location) 48)
    (= (distance_location livestock_4_location robot_initial_location) 48)

    (= (distance_location robot_initial_location livestock_5_location) 44)
    (= (distance_location livestock_5_location robot_initial_location) 44)

    (= (distance_location robot_initial_location livestock_6_location) 74)
    (= (distance_location livestock_6_location robot_initial_location) 74)

    (= (distance_location robot_initial_location livestock_7_location) 27)
    (= (distance_location livestock_7_location robot_initial_location) 27)

    (= (distance_location robot_initial_location robot_2_location) 49)
    (= (distance_location robot_2_location robot_initial_location) 49)

    ; Distance b/w robot location and battery recharging station
    (= (distance_location robot_initial_location station_1) 82)
    (= (distance_location station_1 robot_initial_location) 82)

    ; Distance between robot 2 and everything else
    (= (distance_location robot_2_location box_1_location) 36)
    (= (distance_location box_1_location robot_2_location) 36)

    (= (distance_location robot_2_location box_2_location) 74)
    (= (distance_location box_2_location robot_2_location) 75)

    (= (distance_location robot_2_location livestock_1_location) 28)
    (= (distance_location livestock_1_location robot_2_location) 28)

    (= (distance_location robot_2_location livestock_2_location) 77)
    (= (distance_location livestock_2_location robot_2_location) 77)

    (= (distance_location robot_2_location livestock_3_location) 37)
    (= (distance_location livestock_3_location robot_2_location) 37)

    (= (distance_location robot_2_location livestock_4_location) 28)
    (= (distance_location livestock_4_location robot_2_location) 28)

    (= (distance_location robot_2_location livestock_5_location) 95)
    (= (distance_location livestock_5_location robot_2_location) 95)

    (= (distance_location robot_2_location livestock_6_location) 46)
    (= (distance_location livestock_6_location robot_2_location) 46)

    (= (distance_location robot_2_location livestock_7_location) 82)
    (= (distance_location livestock_7_location robot_2_location) 82)

    (= (distance_location robot_2_location station_1) 66)
    (= (distance_location station_1 robot_2_location) 66)


    ; Distance b/w box 1 location and everything else
    (= (distance_location box_1_location station_1) 96)
    (= (distance_location station_1 box_1_location) 96)

    (= (distance_location box_2_location box_1_location) 7)
    (= (distance_location box_1_location box_2_location) 7)

    (= (distance_location box_1_location livestock_1_location) 37)
    (= (distance_location livestock_1_location box_1_location) 37)

    (= (distance_location box_1_location livestock_2_location) 74)
    (= (distance_location livestock_2_location box_1_location) 74)

    (= (distance_location box_1_location livestock_3_location) 44)
    (= (distance_location livestock_3_location box_1_location) 44)

    (= (distance_location box_1_location livestock_4_location) 21)
    (= (distance_location livestock_4_location box_1_location) 21)

    (= (distance_location box_1_location livestock_5_location) 65)
    (= (distance_location livestock_5_location box_1_location) 65)

    (= (distance_location box_1_location livestock_6_location) 74)
    (= (distance_location livestock_6_location box_1_location) 74)

    (= (distance_location box_1_location livestock_7_location) 36)
    (= (distance_location livestock_7_location box_1_location) 36)

    ; Distance b/w box 2 location and everything else
    (= (distance_location box_2_location station_1) 85)
    (= (distance_location station_1 box_2_location) 85)

    (= (distance_location box_2_location livestock_1_location) 78)
    (= (distance_location livestock_1_location box_2_location) 78)

    (= (distance_location box_2_location livestock_2_location) 64)
    (= (distance_location livestock_2_location box_2_location) 64)

    (= (distance_location box_2_location livestock_3_location) 29)
    (= (distance_location livestock_3_location box_2_location) 29)

    (= (distance_location box_2_location livestock_4_location) 95)
    (= (distance_location livestock_4_location box_2_location) 95)

    (= (distance_location box_2_location livestock_5_location) 52)
    (= (distance_location livestock_5_location box_2_location) 52)

    (= (distance_location box_2_location livestock_6_location) 64)
    (= (distance_location livestock_6_location box_2_location) 64)

    (= (distance_location box_2_location livestock_7_location) 73)
    (= (distance_location livestock_7_location box_2_location) 73)

    (= (distance_location box_2_location station_1) 83)
    (= (distance_location station_1 box_2_location) 83)

    ; Distance b/w station1 and everything else
    (= (distance_location station_1 livestock_1_location) 18)
    (= (distance_location livestock_1_location station_1) 18)

    (= (distance_location station_1 livestock_2_location) 92)
    (= (distance_location livestock_2_location station_1) 92)

    (= (distance_location station_1 livestock_3_location) 96)
    (= (distance_location livestock_3_location station_1) 96)

    (= (distance_location station_1 livestock_4_location) 83)
    (= (distance_location livestock_4_location station_1) 83)

    (= (distance_location station_1 livestock_5_location) 28)
    (= (distance_location livestock_5_location station_1) 28)

    (= (distance_location station_1 livestock_6_location) 47)
    (= (distance_location livestock_6_location station_1) 47)

    (= (distance_location station_1 livestock_7_location) 28)
    (= (distance_location livestock_7_location station_1) 28)

    ; Distance b/w livestock 1 and everything else
    (= (distance_location livestock_1_location livestock_2_location) 55)
    (= (distance_location livestock_2_location livestock_1_location) 55)

    (= (distance_location livestock_1_location livestock_3_location) 22)
    (= (distance_location livestock_3_location livestock_1_location) 22)

    (= (distance_location livestock_1_location livestock_4_location) 64)
    (= (distance_location livestock_4_location livestock_1_location) 64)

    (= (distance_location livestock_1_location livestock_5_location) 14)
    (= (distance_location livestock_5_location livestock_1_location) 14)

    (= (distance_location livestock_1_location livestock_6_location) 85)
    (= (distance_location livestock_6_location livestock_1_location) 85)

    (= (distance_location livestock_1_location livestock_7_location) 36)
    (= (distance_location livestock_7_location livestock_1_location) 24)

    ; Distance b/w livestock 2 and everything else
    (= (distance_location livestock_2_location livestock_3_location) 12)
    (= (distance_location livestock_3_location livestock_2_location) 12)

    (= (distance_location livestock_2_location livestock_4_location) 6)
    (= (distance_location livestock_4_location livestock_2_location) 6)

    (= (distance_location livestock_2_location livestock_5_location) 74)
    (= (distance_location livestock_5_location livestock_2_location) 74)

    (= (distance_location livestock_2_location livestock_6_location) 37)
    (= (distance_location livestock_6_location livestock_2_location) 37)

    (= (distance_location livestock_2_location livestock_7_location) 37)
    (= (distance_location livestock_7_location livestock_2_location) 37)

    ; Distance b/w livestock 3 and everything else
    (= (distance_location livestock_3_location livestock_4_location) 34)
    (= (distance_location livestock_4_location livestock_3_location) 34)

    (= (distance_location livestock_3_location livestock_5_location) 42)
    (= (distance_location livestock_5_location livestock_3_location) 42)

    (= (distance_location livestock_3_location livestock_6_location) 92)
    (= (distance_location livestock_6_location livestock_3_location) 92)

    (= (distance_location livestock_3_location livestock_7_location) 28)
    (= (distance_location livestock_7_location livestock_3_location) 28)

    ; Distance b/w livestock 4 and everything else
    (= (distance_location livestock_4_location livestock_5_location) 63)
    (= (distance_location livestock_5_location livestock_4_location) 63)

    (= (distance_location livestock_4_location livestock_6_location) 62)
    (= (distance_location livestock_6_location livestock_4_location) 62)

    (= (distance_location livestock_4_location livestock_7_location) 74)
    (= (distance_location livestock_7_location livestock_4_location) 74)

    ; Distance b/w livestock 5 and everything else
    (= (distance_location livestock_5_location livestock_6_location) 85)
    (= (distance_location livestock_6_location livestock_5_location) 85)

    (= (distance_location livestock_5_location livestock_7_location) 35)
    (= (distance_location livestock_7_location livestock_5_location) 35)

    ; Distance b/w livestock 6 and 7
    (= (distance_location livestock_6_location livestock_7_location) 75)
    (= (distance_location livestock_7_location livestock_6_location) 75)


    (= (velocity robot_1) 2.55)
    (= (velocity robot_2) 3.52)
    (= (velocity robot_3) 6.63)
    (= (velocity robot_4) 4.95)


    (= (mission-length) 0)

)
(:goal (and
    (contains box_1 crop_5),(box-contains-produce box_2 produce_7),(wet crop_2),(pulverized region_1),(taken-image region_5)
))
(:metric minimize (mission-length))
)
