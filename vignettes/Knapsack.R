## ------------------------------------------------------------------------
library(knapsack)
set.seed(345) 
n <- 3000   
knapsack_objects <- data.frame( w=sample(1:4000, size = n, replace = TRUE),
                                v=runif(n = n, 0, 10000)
)

head(knapsack_objects) 

## ---- warning= FALSE, message= FALSE-------------------------------------
brute_force_knapsack(knapsack_objects[1:8,], W = 3500)

## ---- warning= FALSE, message= FALSE-------------------------------------
brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000)

## ------------------------------------------------------------------------

set.seed(42) 
n <- 16  
knapsack_objects <- data.frame( w=sample(1:4000, size = n, replace = TRUE),
                                v=runif(n = n, 0, 10000))

system.time(brute_force <- brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000))

## ---- warning= FALSE, message= FALSE-------------------------------------
knapsack_dynamic(knapsack_objects[1:8,], W = 3500)

## ---- warning= FALSE, message= FALSE-------------------------------------
knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000)

## ------------------------------------------------------------------------

set.seed(42)
n <- 500
knapsack_objects <- data.frame( w=sample(1:4000, size = n, replace = TRUE),
                                v=runif(n = n, 0, 10000))
system.time(dynamic_result<- knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000))

## ---- warning= FALSE, message= FALSE-------------------------------------
greedy_knapsack(knapsack_objects[1:800,], W = 3500)

## ---- warning= FALSE, message= FALSE-------------------------------------
greedy_knapsack(x = knapsack_objects[1:12,], W = 2000)

## ------------------------------------------------------------------------
set.seed(42) 
n <- 1000000  
knapsack_objects <- data.frame( w=sample(1:4000, size = n, replace = TRUE),
                                v=runif(n = n, 0, 10000))
system.time(greedy_result <- greedy_knapsack(x = knapsack_objects[1:12,], W = 2000))

## ---- echo=TRUE----------------------------------------------------------
library(microbenchmark)

microbenchmark(
  "brute_force"= brute_force, #n= 16
  "dynamic_knapsack" = dynamic_result, #n= 500
  "greedy" = greedy_result ,#n = 1000000
  times = 1,
  unit = "us"
)

