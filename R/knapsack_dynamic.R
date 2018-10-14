
# Lab 6 Knapsack assignment

luid <- "obaur539, muhha866"
name <- "Obaid, Habib"

#'Knapsack solution - Dynamic.


#'@param x A DataFrame with two columns (weight(w) and value(v))
#'@param W Knapsack weight limit
#'
#'@return returns item with maxValue contained in knapsack
#' 
#'@references
#'\url{https://en.wikipedia.org/wiki/Knapsack_problem#Dynamic_programming_in-advance_algorithm}
#'
#'@export


knapsack_dynamic <- function(x, W){
  
  stopifnot(is.data.frame(x) || is.numeric(W) || W > 0)
  
  mat.rix <- matrix(0, nrow = (nrow(x) + 1), ncol =  (W + 1)  )
  rownum = nrow(x) + 1
  wtnum = W+1
  for(i in 2: rownum)
  {
    for(j in 1: wtnum )
    {
      if( x[i-1,1] >= j ) # if greater
        mat.rix[i,j] = mat.rix[i-1, j] # set previous
      else
        mat.rix[i,j] = max(mat.rix[i - 1 ,j] , mat.rix[i - 1 , j - x[i-1,1]] + x[i-1,2] )
    }
  }
  
  # backtrack here
  getMax <- mat.rix[rownum,wtnum]
  j <- wtnum
  k <- rownum
  selected <- rep(FALSE,(rownum))
  #item <- c()
  while( rownum > 1)
  {
    
    if(getMax > mat.rix[k,j])
    {
      value <- (j - x[k,1])
      if (value > 0) {
        if( (mat.rix[k,value] + x[k,2]) == mat.rix[k+1,j])
        {
          selected[k] <- TRUE
          j <- value
        }
      }
      else
        break
    }
    k <- k - 1
  }
  
  items <- which(selected)
  return(list( value = round(max(mat.rix)) , elements = items))
}
