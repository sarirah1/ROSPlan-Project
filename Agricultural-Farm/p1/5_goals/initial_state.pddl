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
    (aerial_at robot_3 base_1)
    (aerial_at robot_4 base_3)

    (= (battery-amount robot_1) 60)
    (= (battery-amount robot_2) 79)
    (= (battery-amount robot_3) 31)
    (= (battery-amount robot_4) 51)

    ; (= (input-amount robot_1) 1)
    (= (input-amount robot_3) 1)
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

    (= (food-capacity) 2)

    (= (water-amount robot_1) 0)
    (= (water-amount robot_2) 1)

    (= (water-capacity) 3)

    (= (discharge-rate-battery) 0.0532)

    (= (battery-capacity) 200)

    (= (input-capacity) 2)

    ; Region 1 distance with other regions
    (= (distance region_1 region_2) 533)
    (= (distance region_2 region_1) 533)

    (= (distance region_1 region_3) 532)
    (= (distance region_3 region_1) 532)

    (= (distance region_1 region_4) 833)
    (= (distance region_4 region_1) 833)

    (= (distance region_1 region_5) 332)
    (= (distance region_5 region_1) 332)

    (= (distance region_1 region_6) 221)
    (= (distance region_6 region_1) 221)

    ; Region 2 distance with other regions
    (= (distance region_2 region_3) 879)
    (= (distance region_3 region_2) 879)

    (= (distance region_2 region_4) 105)
    (= (distance region_4 region_2) 105)

    (= (distance region_2 region_5) 577)
    (= (distance region_5 region_2) 577)

    (= (distance region_2 region_6) 885)
    (= (distance region_6 region_2) 885)

    ; Region 3 distance with other regions
    (= (distance region_3 region_4) 554)
    (= (distance region_4 region_3) 554)

    (= (distance region_3 region_5) 444)
    (= (distance region_5 region_3) 444)

    (= (distance region_3 region_6) 685)
    (= (distance region_6 region_3) 685)

    ; Region 4 distance with other regions
    (= (distance region_4 region_5) 663)
    (= (distance region_5 region_4) 663)

    (= (distance region_4 region_6) 349)
    (= (distance region_6 region_4) 349)

    ; Region 6 and 5 distance with other regions
    (= (distance region_5 region_6) 433)
    (= (distance region_6 region_5) 433)

    ; Region 2 with bases
    (= (distance base_1 region_2) 55)
    (= (distance region_2 base_1) 55)

    (= (distance base_2 region_2) 380)
    (= (distance region_2 base_2) 380)

    (= (distance base_3 region_2) 495)
    (= (distance region_2 base_3) 495)

    ; Region 1 with bases
    (= (distance base_1 region_1) 423)
    (= (distance region_1 base_1) 423)

    (= (distance base_2 region_1) 742)
    (= (distance region_1 base_2) 742)

    (= (distance base_3 region_1) 33)
    (= (distance region_1 base_3) 33)

    ; Region 5 with bases
    (= (distance base_1 region_5) 753)
    (= (distance region_5 base_1) 753)

    (= (distance base_2 region_5) 773)
    (= (distance region_5 base_2) 773)

    (= (distance base_3 region_5) 426)
    (= (distance region_5 base_3) 426)

    ; Region 6 with bases
    (= (distance base_1 region_6) 858)
    (= (distance region_6 base_1) 858)

    (= (distance base_2 region_6) 550)
    (= (distance region_6 base_2) 550)

    (= (distance base_3 region_6) 32)
    (= (distance region_6 base_3) 32)

    ; Region 3 with bases
    (= (distance base_1 region_3) 567)
    (= (distance region_3 base_1) 567)

    (= (distance base_2 region_3) 743)
    (= (distance region_3 base_2) 743)

    (= (distance base_3 region_3) 742)
    (= (distance region_3 base_3) 742)

    ; Region 4 with bases
    (= (distance base_1 region_4) 69)
    (= (distance region_4 base_1) 69)

    (= (distance base_2 region_4) 642)
    (= (distance region_4 base_2) 642)

    (= (distance base_3 region_4) 93)
    (= (distance region_4 base_3) 93)

    ; Base distance with one another
    (= (distance base_1 base_2) 239)
    (= (distance base_2 base_1) 239)

    (= (distance base_1 base_3) 632)
    (= (distance base_3 base_1) 632)

    (= (distance base_2 base_3) 456)
    (= (distance base_3 base_2) 456)




   ; Distance between crop 1 and everthing else
    (= (distance_location crop_1_location crop_2_location) 75)
    (= (distance_location crop_2_location crop_1_location) 75)

    (= (distance_location crop_1_location crop_3_location) 72)
    (= (distance_location crop_3_location crop_1_location) 72)

    (= (distance_location crop_1_location crop_4_location) 18)
    (= (distance_location crop_4_location crop_1_location) 18)

    (= (distance_location crop_1_location crop_5_location) 53)
    (= (distance_location crop_5_location crop_1_location) 53)

    (= (distance_location crop_1_location robot_initial_location) 62)
    (= (distance_location robot_initial_location crop_1_location) 62)
    
    (= (distance_location crop_1_location box_1_location) 92)
    (= (distance_location box_1_location crop_1_location) 92)

    (= (distance_location crop_1_location box_2_location) 27)
    (= (distance_location box_2_location crop_1_location) 27)

    (= (distance_location crop_1_location station_1) 82)
    (= (distance_location station_1 crop_1_location) 82)

    (= (distance_location crop_1_location livestock_1_location) 30)
    (= (distance_location livestock_1_location crop_1_location) 30)

    (= (distance_location crop_1_location livestock_2_location) 74)
    (= (distance_location livestock_2_location crop_1_location) 74)

    (= (distance_location crop_1_location livestock_3_location) 62)
    (= (distance_location livestock_3_location crop_1_location) 62)

    (= (distance_location crop_1_location livestock_4_location) 17)
    (= (distance_location livestock_4_location crop_1_location) 17)

    (= (distance_location crop_1_location livestock_5_location) 70)
    (= (distance_location livestock_5_location crop_1_location) 70)

    (= (distance_location crop_1_location livestock_6_location) 15)
    (= (distance_location livestock_6_location crop_1_location) 15)

    (= (distance_location crop_1_location livestock_7_location) 51)
    (= (distance_location livestock_7_location crop_1_location) 51)

    (= (distance_location crop_1_location robot_2_location) 81)
    (= (distance_location robot_2_location crop_1_location) 81)

    ; Distance of crop 2 with everything else
    (= (distance_location crop_2_location crop_3_location) 99)
    (= (distance_location crop_3_location crop_2_location) 99)

    (= (distance_location crop_2_location crop_4_location) 48)
    (= (distance_location crop_4_location crop_2_location) 48)

    (= (distance_location crop_2_location crop_5_location) 79)
    (= (distance_location crop_5_location crop_2_location) 79)

    (= (distance_location crop_2_location robot_initial_location) 81)
    (= (distance_location robot_initial_location crop_2_location) 81)
    
    (= (distance_location crop_2_location box_1_location) 33)
    (= (distance_location box_1_location crop_2_location) 33)

    (= (distance_location crop_2_location box_2_location) 87)
    (= (distance_location box_2_location crop_2_location) 87)

    (= (distance_location crop_2_location station_1) 83)
    (= (distance_location station_1 crop_2_location) 83)

    (= (distance_location crop_2_location livestock_1_location) 17)
    (= (distance_location livestock_1_location crop_2_location) 17)

    (= (distance_location crop_2_location livestock_2_location) 20)
    (= (distance_location livestock_2_location crop_2_location) 20)

    (= (distance_location crop_2_location livestock_3_location) 74)
    (= (distance_location livestock_3_location crop_2_location) 74)

    (= (distance_location crop_2_location livestock_4_location) 85)
    (= (distance_location livestock_4_location crop_2_location) 85)

    (= (distance_location crop_2_location livestock_5_location) 28)
    (= (distance_location livestock_5_location crop_2_location) 28)

    (= (distance_location crop_2_location livestock_6_location) 69)
    (= (distance_location livestock_6_location crop_2_location) 69)

    (= (distance_location crop_2_location livestock_7_location) 63)
    (= (distance_location livestock_7_location crop_2_location) 63)

    (= (distance_location crop_2_location robot_2_location) 84)
    (= (distance_location robot_2_location crop_2_location) 84)

    
    ; Distance of crop 3 with everything else
    (= (distance_location crop_3_location crop_4_location) 71)
    (= (distance_location crop_4_location crop_3_location) 71)

    (= (distance_location crop_3_location crop_5_location) 21)
    (= (distance_location crop_5_location crop_3_location) 21)
    
    (= (distance_location crop_3_location robot_initial_location) 10)
    (= (distance_location robot_initial_location crop_3_location) 10)
    
    (= (distance_location crop_3_location box_1_location) 63)
    (= (distance_location box_1_location crop_3_location) 63)

    (= (distance_location crop_3_location box_2_location) 8)
    (= (distance_location box_2_location crop_3_location) 8)

    (= (distance_location crop_3_location station_1) 59)
    (= (distance_location station_1 crop_3_location) 69)

    (= (distance_location crop_3_location livestock_1_location) 28)
    (= (distance_location livestock_1_location crop_3_location) 28)

    (= (distance_location crop_3_location livestock_2_location) 62)
    (= (distance_location livestock_2_location crop_3_location) 62)

    (= (distance_location crop_3_location livestock_3_location) 92)
    (= (distance_location livestock_3_location crop_3_location) 92)

    (= (distance_location crop_3_location livestock_4_location) 25)
    (= (distance_location livestock_4_location crop_3_location) 25)

    (= (distance_location crop_3_location livestock_5_location) 27)
    (= (distance_location livestock_5_location crop_3_location) 27)

    (= (distance_location crop_3_location livestock_6_location) 74)
    (= (distance_location livestock_6_location crop_3_location) 74)

    (= (distance_location crop_3_location livestock_7_location) 26)
    (= (distance_location livestock_7_location crop_3_location) 26)

    (= (distance_location crop_3_location robot_2_location) 60)
    (= (distance_location robot_2_location crop_3_location) 60)

    ; Distance of crop 4 with everything else
    (= (distance_location crop_4_location crop_5_location) 31)
    (= (distance_location crop_5_location crop_4_location) 31)
    
    (= (distance_location crop_4_location robot_initial_location) 62)
    (= (distance_location robot_initial_location crop_4_location) 62)
    
    (= (distance_location crop_4_location box_1_location) 37)
    (= (distance_location box_1_location crop_4_location) 37)

    (= (distance_location crop_4_location box_2_location) 56)
    (= (distance_location box_2_location crop_4_location) 56)

    (= (distance_location crop_4_location station_1) 55)
    (= (distance_location station_1 crop_4_location) 55)

    (= (distance_location crop_4_location livestock_1_location) 92)
    (= (distance_location livestock_1_location crop_4_location) 92)

    (= (distance_location crop_4_location livestock_2_location) 52)
    (= (distance_location livestock_2_location crop_4_location) 52)

    (= (distance_location crop_4_location livestock_3_location) 78)
    (= (distance_location livestock_3_location crop_4_location) 78)

    (= (distance_location crop_4_location livestock_4_location) 6)
    (= (distance_location livestock_4_location crop_4_location) 6)

    (= (distance_location crop_4_location livestock_5_location) 27)
    (= (distance_location livestock_5_location crop_4_location) 27)

    (= (distance_location crop_4_location livestock_6_location) 40)
    (= (distance_location livestock_6_location crop_4_location) 40)

    (= (distance_location crop_4_location livestock_7_location) 64)
    (= (distance_location livestock_7_location crop_4_location) 64)

    (= (distance_location crop_4_location robot_2_location) 91)
    (= (distance_location robot_2_location crop_4_location) 91)

    ; Distance of crop 5 with everything else    
    (= (distance_location crop_5_location robot_initial_location) 19)
    (= (distance_location robot_initial_location crop_5_location) 19)
    
    (= (distance_location crop_5_location box_1_location) 83)
    (= (distance_location box_1_location crop_5_location) 83)

    (= (distance_location crop_5_location box_2_location) 82)
    (= (distance_location box_2_location crop_5_location) 82)

    (= (distance_location crop_5_location station_1) 38)
    (= (distance_location station_1 crop_5_location) 38)

    (= (distance_location crop_5_location livestock_1_location) 76)
    (= (distance_location livestock_1_location crop_5_location) 76)

    (= (distance_location crop_5_location livestock_2_location) 26)
    (= (distance_location livestock_2_location crop_5_location) 26)

    (= (distance_location crop_5_location livestock_3_location) 70)
    (= (distance_location livestock_3_location crop_5_location) 70)

    (= (distance_location crop_5_location livestock_4_location) 36)
    (= (distance_location livestock_4_location crop_5_location) 36)

    (= (distance_location crop_5_location livestock_5_location) 53)
    (= (distance_location livestock_5_location crop_5_location) 53)

    (= (distance_location crop_5_location livestock_6_location) 78)
    (= (distance_location livestock_6_location crop_5_location) 78)

    (= (distance_location crop_5_location livestock_7_location) 33)
    (= (distance_location livestock_7_location crop_5_location) 33)

    (= (distance_location crop_5_location robot_2_location) 96)
    (= (distance_location robot_2_location crop_5_location) 96)

    ; Distance between box and robot location
    (= (distance_location robot_initial_location box_1_location) 22)
    (= (distance_location box_1_location robot_initial_location) 22)

    (= (distance_location robot_initial_location box_2_location) 85)
    (= (distance_location box_2_location robot_initial_location) 85)

    ; Distance b/w robot location and livestock locations
    (= (distance_location robot_initial_location livestock_1_location) 81)
    (= (distance_location livestock_1_location robot_initial_location) 81)

    (= (distance_location robot_initial_location livestock_2_location) 16)
    (= (distance_location livestock_2_location robot_initial_location) 16)

    (= (distance_location robot_initial_location livestock_3_location) 25)
    (= (distance_location livestock_3_location robot_initial_location) 25)

    (= (distance_location robot_initial_location livestock_4_location) 85)
    (= (distance_location livestock_4_location robot_initial_location) 85)

    (= (distance_location robot_initial_location livestock_5_location) 38)
    (= (distance_location livestock_5_location robot_initial_location) 38)

    (= (distance_location robot_initial_location livestock_6_location) 93)
    (= (distance_location livestock_6_location robot_initial_location) 93)

    (= (distance_location robot_initial_location livestock_7_location) 53)
    (= (distance_location livestock_7_location robot_initial_location) 53)

    (= (distance_location robot_initial_location robot_2_location) 78)
    (= (distance_location robot_2_location robot_initial_location) 78)

    ; Distance b/w robot location and battery recharging station
    (= (distance_location robot_initial_location station_1) 63)
    (= (distance_location station_1 robot_initial_location) 63)

    ; Distance between robot 2 and everything else
    (= (distance_location robot_2_location box_1_location) 27)
    (= (distance_location box_1_location robot_2_location) 27)

    (= (distance_location robot_2_location box_2_location) 82)
    (= (distance_location box_2_location robot_2_location) 82)

    (= (distance_location robot_2_location livestock_1_location) 73)
    (= (distance_location livestock_1_location robot_2_location) 73)

    (= (distance_location robot_2_location livestock_2_location) 39)
    (= (distance_location livestock_2_location robot_2_location) 39)

    (= (distance_location robot_2_location livestock_3_location) 74)
    (= (distance_location livestock_3_location robot_2_location) 74)

    (= (distance_location robot_2_location livestock_4_location) 22)
    (= (distance_location livestock_4_location robot_2_location) 22)

    (= (distance_location robot_2_location livestock_5_location) 88)
    (= (distance_location livestock_5_location robot_2_location) 88)

    (= (distance_location robot_2_location livestock_6_location) 53)
    (= (distance_location livestock_6_location robot_2_location) 53)

    (= (distance_location robot_2_location livestock_7_location) 96)
    (= (distance_location livestock_7_location robot_2_location) 96)

    (= (distance_location robot_2_location station_1) 27)
    (= (distance_location station_1 robot_2_location) 27)


    ; Distance b/w box 1 location and everything else
    (= (distance_location box_1_location station_1) 96)
    (= (distance_location station_1 box_1_location) 96)

    (= (distance_location box_2_location box_1_location) 67)
    (= (distance_location box_1_location box_2_location) 67)

    (= (distance_location box_1_location livestock_1_location) 37)
    (= (distance_location livestock_1_location box_1_location) 37)

    (= (distance_location box_1_location livestock_2_location) 84)
    (= (distance_location livestock_2_location box_1_location) 84)

    (= (distance_location box_1_location livestock_3_location) 32)
    (= (distance_location livestock_3_location box_1_location) 32)

    (= (distance_location box_1_location livestock_4_location) 82)
    (= (distance_location livestock_4_location box_1_location) 82)

    (= (distance_location box_1_location livestock_5_location) 5)
    (= (distance_location livestock_5_location box_1_location) 5)

    (= (distance_location box_1_location livestock_6_location) 11)
    (= (distance_location livestock_6_location box_1_location) 11)

    (= (distance_location box_1_location livestock_7_location) 85)
    (= (distance_location livestock_7_location box_1_location) 85)

    ; Distance b/w box 2 location and everything else
    (= (distance_location box_2_location station_1) 33)
    (= (distance_location station_1 box_2_location) 33)

    (= (distance_location box_2_location livestock_1_location) 70)
    (= (distance_location livestock_1_location box_2_location) 70)

    (= (distance_location box_2_location livestock_2_location) 59)
    (= (distance_location livestock_2_location box_2_location) 59)

    (= (distance_location box_2_location livestock_3_location) 38)
    (= (distance_location livestock_3_location box_2_location) 38)

    (= (distance_location box_2_location livestock_4_location) 28)
    (= (distance_location livestock_4_location box_2_location) 28)

    (= (distance_location box_2_location livestock_5_location) 69)
    (= (distance_location livestock_5_location box_2_location) 69)

    (= (distance_location box_2_location livestock_6_location) 92)
    (= (distance_location livestock_6_location box_2_location) 92)

    (= (distance_location box_2_location livestock_7_location) 82)
    (= (distance_location livestock_7_location box_2_location) 82)

    (= (distance_location box_2_location station_1) 80)
    (= (distance_location station_1 box_2_location) 80)

    ; Distance b/w station1 and everything else
    (= (distance_location station_1 livestock_1_location) 38)
    (= (distance_location livestock_1_location station_1) 38)

    (= (distance_location station_1 livestock_2_location) 92)
    (= (distance_location livestock_2_location station_1) 92)

    (= (distance_location station_1 livestock_3_location) 29)
    (= (distance_location livestock_3_location station_1) 29)

    (= (distance_location station_1 livestock_4_location) 39)
    (= (distance_location livestock_4_location station_1) 39)

    (= (distance_location station_1 livestock_5_location) 72)
    (= (distance_location livestock_5_location station_1) 72)

    (= (distance_location station_1 livestock_6_location) 98)
    (= (distance_location livestock_6_location station_1) 98)

    (= (distance_location station_1 livestock_7_location) 35)
    (= (distance_location livestock_7_location station_1) 35)

    ; Distance b/w livestock 1 and everything else
    (= (distance_location livestock_1_location livestock_2_location) 42)
    (= (distance_location livestock_2_location livestock_1_location) 42)

    (= (distance_location livestock_1_location livestock_3_location) 63)
    (= (distance_location livestock_3_location livestock_1_location) 63)

    (= (distance_location livestock_1_location livestock_4_location) 83)
    (= (distance_location livestock_4_location livestock_1_location) 83)

    (= (distance_location livestock_1_location livestock_5_location) 36)
    (= (distance_location livestock_5_location livestock_1_location) 36)

    (= (distance_location livestock_1_location livestock_6_location) 18)
    (= (distance_location livestock_6_location livestock_1_location) 18)

    (= (distance_location livestock_1_location livestock_7_location) 21)
    (= (distance_location livestock_7_location livestock_1_location) 21)

    ; Distance b/w livestock 2 and everything else
    (= (distance_location livestock_2_location livestock_3_location) 60)
    (= (distance_location livestock_3_location livestock_2_location) 60)

    (= (distance_location livestock_2_location livestock_4_location) 62)
    (= (distance_location livestock_4_location livestock_2_location) 62)

    (= (distance_location livestock_2_location livestock_5_location) 49)
    (= (distance_location livestock_5_location livestock_2_location) 49)

    (= (distance_location livestock_2_location livestock_6_location) 58)
    (= (distance_location livestock_6_location livestock_2_location) 58)

    (= (distance_location livestock_2_location livestock_7_location) 22)
    (= (distance_location livestock_7_location livestock_2_location) 22)

    ; Distance b/w livestock 3 and everything else
    (= (distance_location livestock_3_location livestock_4_location) 65)
    (= (distance_location livestock_4_location livestock_3_location) 65)

    (= (distance_location livestock_3_location livestock_5_location) 72)
    (= (distance_location livestock_5_location livestock_3_location) 72)

    (= (distance_location livestock_3_location livestock_6_location) 92)
    (= (distance_location livestock_6_location livestock_3_location) 92)

    (= (distance_location livestock_3_location livestock_7_location) 63)
    (= (distance_location livestock_7_location livestock_3_location) 63)

    ; Distance b/w livestock 4 and everything else
    (= (distance_location livestock_4_location livestock_5_location) 91)
    (= (distance_location livestock_5_location livestock_4_location) 91)

    (= (distance_location livestock_4_location livestock_6_location) 73)
    (= (distance_location livestock_6_location livestock_4_location) 73)

    (= (distance_location livestock_4_location livestock_7_location) 68)
    (= (distance_location livestock_7_location livestock_4_location) 68)

    ; Distance b/w livestock 5 and everything else
    (= (distance_location livestock_5_location livestock_6_location) 29)
    (= (distance_location livestock_6_location livestock_5_location) 29)

    (= (distance_location livestock_5_location livestock_7_location) 71)
    (= (distance_location livestock_7_location livestock_5_location) 71)

    ; Distance b/w livestock 6 and 7
    (= (distance_location livestock_6_location livestock_7_location) 93)
    (= (distance_location livestock_7_location livestock_6_location) 93)


    (= (velocity robot_1) 6.24)
    (= (velocity robot_2) 6.21)
    (= (velocity robot_3) 2.74)
    (= (velocity robot_4) 5.82)


    (= (mission-length) 0)

)
(:goal (and
))
(:metric minimize (mission-length))
)
