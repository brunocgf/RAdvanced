library(purrr)
library(memoise)


# Existing function operators ---------------------------------------------

x <- list(
  c(0.512, 0.165, 0.717),
  c(0.064, 0.781, 0.427),
  c(0.890, 0.785, 0.495),
  "oops"
)

out <- rep(NA_real_, length(x))
for (i in seq_along(x)) {
  out[[i]] <- sum(x[[i]])
}

out <- transpose(map(x, safely(sum)))


fib <- function(n) {
  if (n < 2) return(1)
  fib(n - 2) + fib(n - 1)
}
system.time(fib(30))

system.time(fib(33))

fib2 <- memoise::memoise(function(n) {
  if (n < 2) return(1)
  fib2(n - 2) + fib2(n - 1)
})

system.time(fib2(30))
system.time(fib2(33))

## Base R provides a function operator in the form of Vectorize(). What does it do? When might you use it?

?Vectorize


# Case study: Creating your own function operators ------------------------

delay_by <- function(f, amount) {
  force(f)
  force(amount)
  
  function(...) {
    Sys.sleep(amount)
    f(...)
  }
}

dot_every <- function(f, n) {
  force(f)
  force(n)
  
  i <- 0
  function(...) {
    i <<- i + 1
    if (i %% n == 0) cat(".")
    f(...)
  }
}
walk(1:100, runif)
walk(1:100, runif %>% dot_every(10) %>% delay_by(0.1))

## Weigh the pros and cons of
## download.file %>% dot_every(10) %>% delay_by(0.1) versus 
## download.file %>% delay_by(0.1) %>% dot_every(10).

walk(1:100, runif %>% delay_by(10) %>% dot_every(0.1))
