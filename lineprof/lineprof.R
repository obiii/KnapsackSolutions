devtools::install_github("hadley/lineprof")
library(lineprof)

set.seed(42)
n <- 2000
knapsack_objects <- data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
  )

source(paste(getwd(),"R","brute_force_knapsack.R", sep = "/"))
brute_force <- lineprof(brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500))
brute_force_parallel <- lineprof(brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500, parallel = TRUE))

source(paste(getwd(),"R","knapsack_dynamic.R", sep = "/"))
dynamic <- lineprof(knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500))

source(paste(getwd(),"R","greedy_knapsack.R", sep = "/"))
greedy <- lineprof(greedy_knapsack(x = knapsack_objects[1:1500,], W = 3500))
