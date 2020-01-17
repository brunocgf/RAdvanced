
# Choices -----------------------------------------------------------------

x <- 1:10

ifelse(x %% 5 == 0, "XXX", as.character(x))

ifelse(x %% 2 == 0, "even", "odd")

dplyr::case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  is.na(x) ~ "???",
  TRUE ~ as.character(x)
)

x_option <- function(x) {
  switch(x,
         a = "option 1",
         b = "option 2",
         c = "option 3",
         stop("Invalid `x` value")
  )
}

## What type of vector does each of the following calls to ifelse() return?

ifelse(TRUE, 1, "no")
ifelse(FALSE, 1, "no")
ifelse(NA, 1, "no")

## Why does the following code work?

x <- 1:10
if (length(x)) "not empty" else "empty"

x <- numeric()
if (length(x)) "not empty" else "empty"


# Loops -------------------------------------------------------------------

means <- c(1, 50, 20)
out <- vector("list", length(means))
for (i in 1:length(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}

## Why does this code succeed without errors or warnings?

x <- numeric()
out <- vector("list", length(x))
for (i in 1:length(x)) {
  out[i] <- x[i] ^ 2
}
out

## When the following code is evaluated, what can you say about the vector being iterated?

xs <- c(1, 2, 3)
for (x in xs) {
  xs <- c(xs, x * 2)
}
xs

## What does the following code tell you about when the index is updated?

for (i in 1:3) {
  i <- i * 2
  print(i) 
}
