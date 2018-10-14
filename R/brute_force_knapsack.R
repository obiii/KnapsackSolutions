
# Lab 6 Knapsack assignment

luid <- "obaur539, muhha866"
name <- "Obaid, Habib"

#'Knapsack solution - Brute Force

#'@name brute_force_knapsack
#'@param x A DataFrame with two columns (weight(w) and value(v))
#'@param W Knapsack weight limit
#'@param parallel default = FALSE 
#'@return returns item with maxValue contained in knapsack
#' 
#'@references
#'\url{https://en.wikipedia.org/wiki/Knapsack_problem#Dynamic_programming_in-advance_algorithm}
#'
#'@import parallel
#'@import combinat
#'@import microbenchmark
#'@export

brute_force_knapsack <- function(x, W, parallel = FALSE){

  if(!(is.data.frame(x)) || !(is.numeric(W)) || W < 0 )
    stop()
  #stopifnot(is.data.frame(x) || is.numeric(W) || W > 0) NOT WORKING EVEN with & operator
  
  wv.comb <- list() 
  item.values <- list() 
  systems <- c("Windows","linux","Darwin")
  if( parallel == TRUE )
  {
    if(Sys.info()["sysname"] %in% systems)
    {
      cores = parallel::detectCores() 
      wv.comb <- unlist(parallel::mclapply(1:nrow(x),
                                    function(k) 
                                    {
                                      combinat::combn(rownames(x), m = k, simplify = FALSE, fun = as.numeric)
                                    },
                              mc.cores = cores),
                     recursive = FALSE, use.names = FALSE)

      #sum the item result of each core
      item.values <- parallel::mclapply(wv.comb, function(wv.comb){
                              ifelse(sum(x[wv.comb,1]) <= W,
                                     sum(x[wv.comb,2]),0
                                     )
                            },
                          mc.cores = cores)

    }
    else
    {
      stop("Unable to fetch system information")
    }
  }
  else
  {
    wv.comb <- unlist(lapply(1:nrow(x), function(k){
                            combinat::combn(rownames(x), m = k, simplify = FALSE, fun = as.numeric)}),
                            use.names = FALSE,recursive = FALSE)
    item.values <- lapply(wv.comb, function(wv.comb)
      {
        ifelse(sum(x[wv.comb,1]) <= W , sum(x[wv.comb,2]),0)
      }
      )
  }

  max.ind <- which.max(item.values) #get a max value from list
  items.selected <- wv.comb[[max.ind]] #select items

  return(list(value=round(item.values[[max.ind]]),elements = items.selected))
}
