library(rlang)
library(purrr)


# Evaluation basics -------------------------------------------------------

## Predict the results of the following lines of code:

eval(expr(eval(expr(eval(expr(2 + 2))))))
eval(eval(expr(eval(expr(eval(expr(2 + 2)))))))
expr(eval(expr(eval(expr(eval(expr(2 + 2)))))))


# Quosures ----------------------------------------------------------------

f <- function(df,h){
  #h <- expr(h)
  #dplyr::select(df,!!h)
  eval(expr(dplyr::select(df,h)))
}
