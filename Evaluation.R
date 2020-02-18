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


f <- function(df,x){
  x <- enquo(x)
  dplyr::select(df,!!x)
}


# Base evaluation ---------------------------------------------------------

f2 <- function(df,x){
  x <- substitute(x)
  dplyr::select(df,x)
}

with_html(
  body(
    h1("A heading", id = "first"),
    p("Some text &", b("some bold text.")),
    img(src = "myimg.png", width = 100, height = 100)
  )
)

