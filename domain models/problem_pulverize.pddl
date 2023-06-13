(define (problem task)
(:domain harpia)
(:objects
    region_1 region_2 region_3 region_4 region_5 region_6 - region
    base_1 base_2 base_3 - base
)
(:init
    (at base_1)

    (pulverize-goal region_2)
    (pulverize-goal region_1)

    (= (battery-amount) 50)

    (= (input-amount) 3)

    (= (discharge-rate-battery) 0.062)

    (= (battery-capacity) 100)

    (= (input-capacity) 3)


    (= (distance region_2 region_1) 123.934)
    (= (distance region_2 base_1) 412.039)
    (= (distance region_2 base_2) 69.629)
    (= (distance region_2 base_3) 151.901)
    (= (distance region_1 region_2) 123.934)
    (= (distance region_1 base_1) 238.573)
    (= (distance region_1 base_2) 447.481)
    (= (distance region_1 base_3) 138.646)
    (= (distance base_1 region_2) 412.039)
    (= (distance base_1 region_1) 238.573)
    (= (distance base_1 base_2) 94.942)
    (= (distance base_1 base_3) 306.234)
    (= (distance base_2 region_2) 69.629)
    (= (distance base_2 region_1) 447.481)
    (= (distance base_2 base_1) 94.942)
    (= (distance base_2 base_3) 59.892)
    (= (distance base_3 region_2) 151.901)
    (= (distance base_3 region_1) 138.646)
    (= (distance base_3 base_1) 306.2343)
    (= (distance base_3 base_2) 59.892)


    (= (velocity) 5.1)


    (= (mission-length) 0)

)
(:goal (and
    (pulverized region_2)
    (pulverized region_1)
))
(:metric minimize (mission-length))
)