# Lab 6 Knapsack assignment

luid <- "obaur539, muhha866"
name <- "Obaid, Habib"

#'Knapsack solution - Greedy

#'@param x A DataFrame with two columns (weight(w) and value(v))
#'@param W Knapsack weight limit
#'
#'@return returns item with maxValue contained in knapsack
#' 
#'@references
#'\url{https://en.wikipedia.org/wiki/Knapsack_problem#Dynamic_programming_in-advance_algorithm}
#'
#'@export

greedy_knapsack <- function(x, W)
{
  
  if(!(is.data.frame(x)) || !(is.numeric(W)) || W < 0 )
    stop()
  #stopifnot(is.data.frame(x) || is.numeric(W) || W > 0) NOT WORKING EVEN with & operator
  
  x$density <- round(x$v / x$w, digits = 3) #get density
  x <- x[order(x$density , decreasing = TRUE),] #rearrange density in descending order
  
 
  item.list <- c()
  weight.sum <- 0
  tVal <- 0
  k <- 1
  
  repeat
  {
    if( weight.sum + x[k,1] < W  )
    {
      tVal <- tVal + x[k,2]
      weight.sum <- weight.sum + x[k,1]
      item.list[k] <- as.numeric(rownames(x[k,]))
      k <- k + 1
    }
    else
      break
  }
  return(list(value=round(tVal), elements=item.list))
}

