(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base

    robot_1 robot_2 - ground
    robot_3 - aerial
    box_1 box_2 - box
    crop_1 crop_2 crop_3 crop_4 crop_5 - crop
    livestock_1 livestock_2 livestock_3 livestock_4 - livestock
    crop_1_location crop_2_location crop_3_location crop_4_location crop_5_location robot_initial_location box_1_location box_2_location livestock_1_location livestock_2_location livestock_3_location livestock_4_location robot_2_location - position
    station_1 - charging-station
    produce_1 - produce

)
(:init
    (at robot_3 base_1)

    (picture-goal region_5)
    (picture-goal region_6)
    (picture-goal region_1)
    (picture-goal region_2)
    (pulverize-goal region_1)
    (pulverize-goal region_6)
    (pulverize-goal region_3)
    (pulverize-goal region_4)
    (put-into-box-goal box_1 crop_1)
    (put-into-box-goal box_2 crop_2)
    (put-into-box-goal box_2 crop_3)
    (put-into-box-goal box_2 crop_4)
    (put-into-box-goal box_1 crop_5)
    (feed-livestock-goal livestock_1)
    (feed-livestock-goal livestock_2)
    (feed-livestock-goal livestock_3)
    (feed-livestock-goal livestock_4)
    (crop-water-goal crop_2)
    (crop-water-goal crop_3)
    (crop-water-goal crop_5)
    (put-produce-into-box-goal box_1 produce_1)


    (= (battery-amount robot_1) 60)
    (= (battery-amount robot_2) 79)
    (= (battery-amount robot_3) 31)

    ; (= (input-amount robot_1) 1)
    (= (input-amount robot_3) 1)

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


    (livestock-hungry livestock_1)
    (livestock-hungry livestock_2)
    (livestock-hungry livestock_3)
    (livestock-hungry livestock_4)

    (belong_to produce_1 livestock_1)

    (= (food-amount robot_1) 1)
    (= (food-amount robot_2) 2)

    (= (food-capacity) 1)

    (= (water-amount robot_1) 0)
    (= (water-amount robot_2) 0)

    (= (water-capacity) 4)

    (= (discharge-rate-battery) 0.0337)

    (= (battery-capacity) 150)

    (= (input-capacity) 1)

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
    (= (distance_location crop_1_location crop_2_location) 43)
    (= (distance_location crop_2_location crop_1_location) 43)

    (= (distance_location crop_1_location crop_3_location) 54)
    (= (distance_location crop_3_location crop_1_location) 54)

    (= (distance_location crop_1_location crop_4_location) 73)
    (= (distance_location crop_4_location crop_1_location) 73)

    (= (distance_location crop_1_location crop_5_location) 16)
    (= (distance_location crop_5_location crop_1_location) 16)

    (= (distance_location crop_1_location robot_initial_location) 36)
    (= (distance_location robot_initial_location crop_1_location) 36)
    
    (= (distance_location crop_1_location box_1_location) 72)
    (= (distance_location box_1_location crop_1_location) 72)

    (= (distance_location crop_1_location box_2_location) 87)
    (= (distance_location box_2_location crop_1_location) 87)

    (= (distance_location crop_1_location station_1) 33)
    (= (distance_location station_1 crop_1_location) 33)

    (= (distance_location crop_1_location livestock_1_location) 99)
    (= (distance_location livestock_1_location crop_1_location) 99)

    (= (distance_location crop_1_location livestock_2_location) 74)
    (= (distance_location livestock_2_location crop_1_location) 74)

    (= (distance_location crop_1_location livestock_3_location) 62)
    (= (distance_location livestock_3_location crop_1_location) 62)

    (= (distance_location crop_1_location livestock_4_location) 21)
    (= (distance_location livestock_4_location crop_1_location) 21)

    (= (distance_location crop_1_location robot_2_location) 62)
    (= (distance_location robot_2_location crop_1_location) 62)

    ; Distance of crop 2 with everything else
    (= (distance_location crop_2_location crop_3_location) 76)
    (= (distance_location crop_3_location crop_2_location) 76)

    (= (distance_location crop_2_location crop_4_location) 64)
    (= (distance_location crop_4_location crop_2_location) 64)

    (= (distance_location crop_2_location crop_5_location) 29)
    (= (distance_location crop_5_location crop_2_location) 29)

    (= (distance_location crop_2_location robot_initial_location) 81)
    (= (distance_location robot_initial_location crop_2_location) 81)
    
    (= (distance_location crop_2_location box_1_location) 92)
    (= (distance_location box_1_location crop_2_location) 92)

    (= (distance_location crop_2_location box_2_location) 71)
    (= (distance_location box_2_location crop_2_location) 71)

    (= (distance_location crop_2_location station_1) 99)
    (= (distance_location station_1 crop_2_location) 99)

    (= (distance_location crop_2_location livestock_1_location) 11)
    (= (distance_location livestock_1_location crop_2_location) 11)

    (= (distance_location crop_2_location livestock_2_location) 34)
    (= (distance_location livestock_2_location crop_2_location) 34)

    (= (distance_location crop_2_location livestock_3_location) 74)
    (= (distance_location livestock_3_location crop_2_location) 74)

    (= (distance_location crop_2_location livestock_4_location) 42)
    (= (distance_location livestock_4_location crop_2_location) 42)

    (= (distance_location crop_2_location robot_2_location) 75)
    (= (distance_location robot_2_location crop_2_location) 75)

    
    ; Distance of crop 3 with everything else
    (= (distance_location crop_3_location crop_4_location) 82)
    (= (distance_location crop_4_location crop_3_location) 82)

    (= (distance_location crop_3_location crop_5_location) 64)
    (= (distance_location crop_5_location crop_3_location) 64)
    
    (= (distance_location crop_3_location robot_initial_location) 54)
    (= (distance_location robot_initial_location crop_3_location) 53)
    
    (= (distance_location crop_3_location box_1_location) 11)
    (= (distance_location box_1_location crop_3_location) 11)

    (= (distance_location crop_3_location box_2_location) 66)
    (= (distance_location box_2_location crop_3_location) 66)

    (= (distance_location crop_3_location station_1) 31)
    (= (distance_location station_1 crop_3_location) 31)

    (= (distance_location crop_3_location livestock_1_location) 74)
    (= (distance_location livestock_1_location crop_3_location) 74)

    (= (distance_location crop_3_location livestock_2_location) 96)
    (= (distance_location livestock_2_location crop_3_location) 95)

    (= (distance_location crop_3_location livestock_3_location) 25)
    (= (distance_location livestock_3_location crop_3_location) 25)

    (= (distance_location crop_3_location livestock_4_location) 82)
    (= (distance_location livestock_4_location crop_3_location) 82)

    (= (distance_location crop_3_location robot_2_location) 60)
    (= (distance_location robot_2_location crop_3_location) 60)

    ; Distance of crop 4 with everything else
    (= (distance_location crop_4_location crop_5_location) 27)
    (= (distance_location crop_5_location crop_4_location) 27)
    
    (= (distance_location crop_4_location robot_initial_location) 52)
    (= (distance_location robot_initial_location crop_4_location) 52)
    
    (= (distance_location crop_4_location box_1_location) 73)
    (= (distance_location box_1_location crop_4_location) 73)

    (= (distance_location crop_4_location box_2_location) 88)
    (= (distance_location box_2_location crop_4_location) 88)

    (= (distance_location crop_4_location station_1) 38)
    (= (distance_location station_1 crop_4_location) 38)

    (= (distance_location crop_4_location livestock_1_location) 27)
    (= (distance_location livestock_1_location crop_4_location) 27)

    (= (distance_location crop_4_location livestock_2_location) 74)
    (= (distance_location livestock_2_location crop_4_location) 74)

    (= (distance_location crop_4_location livestock_3_location) 93)
    (= (distance_location livestock_3_location crop_4_location) 93)

    (= (distance_location crop_4_location livestock_4_location) 93)
    (= (distance_location livestock_4_location crop_4_location) 93)

    (= (distance_location crop_4_location robot_2_location) 19)
    (= (distance_location robot_2_location crop_4_location) 19)

    ; Distance of crop 5 with everything else    
    (= (distance_location crop_5_location robot_initial_location) 26)
    (= (distance_location robot_initial_location crop_5_location) 26)
    
    (= (distance_location crop_5_location box_1_location) 72)
    (= (distance_location box_1_location crop_5_location) 72)

    (= (distance_location crop_5_location box_2_location) 99)
    (= (distance_location box_2_location crop_5_location) 99)

    (= (distance_location crop_5_location station_1) 8)
    (= (distance_location station_1 crop_5_location) 8)

    (= (distance_location crop_5_location livestock_1_location) 27)
    (= (distance_location livestock_1_location crop_5_location) 27)

    (= (distance_location crop_5_location livestock_2_location) 53)
    (= (distance_location livestock_2_location crop_5_location) 53)

    (= (distance_location crop_5_location livestock_3_location) 96)
    (= (distance_location livestock_3_location crop_5_location) 96)

    (= (distance_location crop_5_location livestock_4_location) 95)
    (= (distance_location livestock_4_location crop_5_location) 95)

    (= (distance_location crop_5_location robot_2_location) 39)
    (= (distance_location robot_2_location crop_5_location) 39)

    ; Distance between box and robot location
    (= (distance_location robot_initial_location box_1_location) 88)
    (= (distance_location box_1_location robot_initial_location) 88)

    (= (distance_location robot_initial_location box_2_location) 22)
    (= (distance_location box_2_location robot_initial_location) 22)

    ; Distance b/w robot location and livestock locations
    (= (distance_location robot_initial_location livestock_1_location) 85)
    (= (distance_location livestock_1_location robot_initial_location) 85)

    (= (distance_location robot_initial_location livestock_2_location) 96)
    (= (distance_location livestock_2_location robot_initial_location) 96)

    (= (distance_location robot_initial_location livestock_3_location) 43)
    (= (distance_location livestock_3_location robot_initial_location) 43)

    (= (distance_location robot_initial_location livestock_4_location) 21)
    (= (distance_location livestock_4_location robot_initial_location) 21)

    (= (distance_location robot_initial_location robot_2_location) 9)
    (= (distance_location robot_2_location robot_initial_location) 9)

    ; Distance b/w robot location and battery recharging station
    (= (distance_location robot_initial_location station_1) 63)
    (= (distance_location station_1 robot_initial_location) 63)

    ; Distance between robot 2 and everything else
    (= (distance_location robot_2_location box_1_location) 55)
    (= (distance_location box_1_location robot_2_location) 55)

    (= (distance_location robot_2_location box_2_location) 72)
    (= (distance_location box_2_location robot_2_location) 72)

    (= (distance_location robot_2_location livestock_1_location) 73)
    (= (distance_location livestock_1_location robot_2_location) 73)

    (= (distance_location robot_2_location livestock_2_location) 84)
    (= (distance_location livestock_2_location robot_2_location) 84)

    (= (distance_location robot_2_location livestock_3_location) 29)
    (= (distance_location livestock_3_location robot_2_location) 29)

    (= (distance_location robot_2_location livestock_4_location) 74)
    (= (distance_location livestock_4_location robot_2_location) 74)

    (= (distance_location robot_2_location station_1) 87)
    (= (distance_location station_1 robot_2_location) 87)


    ; Distance b/w box 1 location and everything else
    (= (distance_location box_1_location station_1) 31)
    (= (distance_location station_1 box_1_location) 31)

    (= (distance_location box_2_location box_1_location) 60)
    (= (distance_location box_1_location box_2_location) 60)

    (= (distance_location box_1_location livestock_1_location) 70)
    (= (distance_location livestock_1_location box_1_location) 70)

    (= (distance_location box_1_location livestock_2_location) 75)
    (= (distance_location livestock_2_location box_1_location) 75)

    (= (distance_location box_1_location livestock_3_location) 88)
    (= (distance_location livestock_3_location box_1_location) 88)

    (= (distance_location box_1_location livestock_4_location) 59)
    (= (distance_location livestock_4_location box_1_location) 59)

    ; Distance b/w box 2 location and everything else
    (= (distance_location box_2_location station_1) 63)
    (= (distance_location station_1 box_2_location) 63)

    (= (distance_location box_2_location livestock_1_location) 78)
    (= (distance_location livestock_1_location box_2_location) 78)

    (= (distance_location box_2_location livestock_2_location) 73)
    (= (distance_location livestock_2_location box_2_location) 73)

    (= (distance_location box_2_location livestock_3_location) 31)
    (= (distance_location livestock_3_location box_2_location) 31)

    (= (distance_location box_2_location livestock_4_location) 85)
    (= (distance_location livestock_4_location box_2_location) 85)


    (= (distance_location box_2_location station_1) 27)
    (= (distance_location station_1 box_2_location) 27)

    ; Distance b/w station1 and everything else
    (= (distance_location station_1 livestock_1_location) 16)
    (= (distance_location livestock_1_location station_1) 16)

    (= (distance_location station_1 livestock_2_location) 37)
    (= (distance_location livestock_2_location station_1) 37)

    (= (distance_location station_1 livestock_3_location) 94)
    (= (distance_location livestock_3_location station_1) 94)

    (= (distance_location station_1 livestock_4_location) 82)
    (= (distance_location livestock_4_location station_1) 82)

    ; Distance b/w livestock 1 and everything else
    (= (distance_location livestock_1_location livestock_2_location) 61)
    (= (distance_location livestock_2_location livestock_1_location) 61)

    (= (distance_location livestock_1_location livestock_3_location) 74)
    (= (distance_location livestock_3_location livestock_1_location) 74)

    (= (distance_location livestock_1_location livestock_4_location) 90)
    (= (distance_location livestock_4_location livestock_1_location) 90)

    ; Distance b/w livestock 3 and everything else
    (= (distance_location livestock_2_location livestock_3_location) 63)
    (= (distance_location livestock_3_location livestock_2_location) 63)

    (= (distance_location livestock_2_location livestock_4_location) 46)
    (= (distance_location livestock_4_location livestock_2_location) 46)

    ; Distance b/w livestock 3 and 4
    (= (distance_location livestock_3_location livestock_4_location) 29)
    (= (distance_location livestock_4_location livestock_3_location) 29)


    (= (velocity robot_1) 4.63)
    (= (velocity robot_2) 6.21)
    (= (velocity robot_3) 7.32)


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

    (contains box_1 crop_1)
    (contains box_2 crop_2)
    (contains box_2 crop_3)
    (contains box_2 crop_4)
    (contains box_1 crop_5)

    (wet crop_2)
    (wet crop_3)
    (wet crop_5)
    (fed livestock_1)
    (fed livestock_2)

    (box-contains-produce box_1 produce_1)
))
(:metric minimize (mission-length))
)
