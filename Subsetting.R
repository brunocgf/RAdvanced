
# Selecting multiple elements ---------------------------------------------

## Positive integers

x <- c(2.1, 4.2, 3.3, 5.4)

x[c(3, 1)]
x[order(x)]


# Duplicate indices will duplicate values
x[c(1, 1)]

# Real numbers are silently truncated to integers
x[c(2.1, 2.9)]

## Negative integers

x[-c(3, 1)]

## Logical vectors

x[c(TRUE, TRUE, FALSE, FALSE)]

x[x > 3]

## Nothing

x[]

## Zero

x[0]

## Character vectors

y <- setNames(x, letters[1:4])

y[c("d", "c", "a")]

# Like integer indices, you can repeat indices
y[c("a", "a", "a")]

## Fix each of the following common data frame subsetting errors:

mtcars[mtcars$cyl == 4, ]
mtcars[1:4, ]
mtcars[mtcars$cyl <= 5,]
mtcars[mtcars$cyl == 4 | mtcars$cyl ==6, ]

## Why does the following code yield five missing values? (Hint: why is it different from x[NA_real_]?)

x <- 1:5
x[NA]
x[NA_real_]

## What does upper.tri() return? How does subsetting a matrix with it work?
## Do we need any additional subsetting rules to describe its behaviour?

x <- outer(1:5, 1:5, FUN = "*")
x[upper.tri(x),]

## Why does mtcars[1:20] return an error? How does it differ from the similar mtcars[1:20, ]?

mtcars[1:2,]

## Implement your own function that extracts the diagonal entries from a matrix (it should behave like diag(x) where x is a matrix).

diagonal <- function(x){
  n = min(dim(x))
  res <- NULL
  for (i in 1:n){
    res[i] <- x[i,i]
  }
  res
}

diagonal(x)

## What does df[is.na(df)] <- 0 do? How does it work?
df[is.na(df)] <- 0


# Selecting a single element ----------------------------------------------


