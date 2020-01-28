library(rlang)
library(ggplot2)
library(scales)

power1 <- function(exp) {
  function(x) {
    x ^ exp
  }
}

square <- power1(2)
cube <- power1(3)

# Factory fundamentals ----------------------------------------------------

square
cube

env_print(square)
env_print(cube)

fn_env(square)$exp
fn_env(cube)$exp

power2 <- function(exp) {
  force(exp)
  function(x) {
    x ^ exp
  }
}

x <- 2
square <- power2(x)
x <- 3
square(2)

## Base R contains two function factories, approxfun() and ecdf().
## Read their documentation and experiment to figure out what the functions do and what they return.

?approxfun
?ecdf

f <- approxfun(c(2,15,18,31,74))

## Create a function pick() that takes an index, i, as an argument and returns a function with an argument x that subsets x with i.

pick <- function(i){
  function(x)
    x[[i]]
}

## What happens if you don’t use a closure? Make predictions, then verify with the code below.

i <- 0
new_counter2 <- function() {
  i <<- i + 1
  i
}

## What happens if you use <- instead of <<-? Make predictions, then verify with the code below.

new_counter3 <- function() {
  i <- 0
  function() {
    i <- i + 1
    i
  }
}


# Graphical factories -----------------------------------------------------

y <- c(12345, 123456, 1234567)
comma_format()(y)

number_format(scale = 1e-3, suffix = " K")(y)

df <- data.frame(x = 1, y = y)
core <- ggplot(df, aes(x, y)) + 
  geom_point() + 
  scale_x_continuous(breaks = 1, labels = NULL) +
  labs(x = NULL, y = NULL)

core
core + scale_y_continuous(
  labels = comma_format()
)
core + scale_y_continuous(
  labels = number_format(scale = 1e-3, suffix = " K")
)
core + scale_y_continuous(
  labels = scientific_format()
)

# construct some sample data with very different numbers in each cell
sd <- c(1, 5, 157)
n <- 100

df <- data.frame(x = rnorm(3 * n, sd = sd), sd = rep(sd, n))

ggplot(df, aes(x)) + 
  geom_histogram(binwidth = 2) + 
  facet_wrap(~ sd, scales = "free_x") + 
  labs(x = NULL)

binwidth_bins <- function(n) {
  force(n)
  
  function(x) {
    (max(x) - min(x)) / n
  }
}

ggplot(df, aes(x)) + 
  geom_histogram(binwidth = binwidth_bins(20)) + 
  facet_wrap(~ sd, scales = "free_x") + 
  labs(x = NULL)

## Compare and contrast ggplot2::label_bquote() with scales::number_format()

?label_bquote
?facet_grid
