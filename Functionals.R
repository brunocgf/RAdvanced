library(purrr)


# My first functional: map() ----------------------------------------------

pair <- function(x) c(x, x)
map(1:2, pair)

x <- list(
  list(-1, x = 1, y = c(2), z = "a"),
  list(-2, x = 4, y = c(5, 6), z = "b"),
  list(-3, x = 8, y = c(9, 10, 11))
)

# Select by name
map_dbl(x, "x")

# Or by position
map_dbl(x, 1)

# Or by both
map_dbl(x, list("y", 1))

# Unless you supply a .default value
map_chr(x, "z", .default = NA)


pluck(x,"x")

## Use as_mapper() to explore how purrr generates anonymous functions for the integer, character, and list helpers.
## What helper allows you to extract attributes? Read the documentation to find out.
attr_getter(x)

## map(1:3, ~ runif(2)) is a useful pattern for generating random numbers, but map(1:3, runif(2)) is not.
## Why not? Can you explain why it returns the result that it does?

typeof(runif)
typeof(runif())

## The following code simulates the performance of a t-test for non-normal data.
## Extract the p-value from each test, then visualise.

trials <- map(1:100, ~ t.test(rpois(10, 10), rpois(7, 10)))

map_dbl(trials,"p.value")

## The following code uses a map nested inside another map to apply a function to every element of a nested list.
## Why does it fail, and what do you need to do to make it work?

x <- list(
  list(1, c(3, 9)),
  list(c(3, 6), 7, c(4, 7, 6))
)

triple <- function(x) x * 3
map(x, ~map(.x, triple))

## Use map() to fit linear models to the mtcars dataset using the formulas stored in this list:

formulas <- list(
  mpg ~ disp,
  mpg ~ I(1 / disp),
  mpg ~ disp + wt,
  mpg ~ I(1 / disp) + wt
)

map(formulas, ~lm(.x, mtcars))

## Fit the model mpg ~ disp to each of the bootstrap replicates of mtcars in the list below, then extract the  R2 of the model fit

bootstrap <- function(df) {
  df[sample(nrow(df), replace = TRUE), , drop = FALSE]
}

bootstraps <- map(1:10, ~ bootstrap(mtcars))

map(bootstraps, ~lm(mpg~disp, .x)) %>% 
  map(summary) %>% 
  map_dbl("r.squared")


# Purrr style -------------------------------------------------------------

by_cyl <- split(mtcars, mtcars$cyl)

by_cyl %>% 
  map(~ lm(mpg ~ wt, data = .x)) %>% 
  map(coef) %>% 
  map_dbl(2)


# Map variants ------------------------------------------------------------

df <- data.frame(
  x = 1:3,
  y = 6:4
)

modify(df, ~ .x * 2)

welcome <- function(x) {
  cat("Welcome ", x, "!\n", sep = "")
}

names <- c("Hadley", "Jenny")

walk(names, welcome)

## Explain the results of modify(mtcars, 1).

modify(mtcars, 1)

## Rewrite the following code to use iwalk() instead of walk2(). What are the advantages and disadvantages?

temp <- tempfile()
cyls <- split(mtcars, mtcars$cyl)
paths <- file.path(temp, paste0("cyl-", names(cyls), ".csv"))
iwalk(cyls, ~write.csv(.x, paste0("cyl-",.y,".csv")))

## Explain how the following code transforms a data frame using functions stored in a list.

trans <- list(
  disp = function(x) x * 0.0163871,
  am = function(x) factor(x, labels = c("auto", "manual"))
)

nm <- names(trans)
mtcars[nm] <- map2(trans, mtcars[nm], function(f, var) f(var))

mtcars[vars] <- map(vars, ~ trans[[.x]](mtcars[[.x]]))