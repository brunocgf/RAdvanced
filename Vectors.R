


# Atomic vectors ----------------------------------------------------------

lgl_var <- c(TRUE, FALSE)
int_var <- c(1L, 6L, 10L)
dbl_var <- c(1, 2.5, 4.5)
chr_var <- c("these are", "some strings")

typeof(lgl_var)
typeof(int_var)
typeof(dbl_var)
typeof(chr_var)



# Attributes --------------------------------------------------------------

a <- 1:3
attr(a, "x") <- "abcdef"
attr(a, "x")

structure(1:5, comment = "my attribute")


# S3 atomic vectors -------------------------------------------------------

x <- factor(c("a", "b", "b", "a"))

typeof(x)

attributes(x)

## What sort of object does table() return? What is its type? What attributes does it have?
## How does the dimensionality change as you tabulate more variables?

t <- table(c(1,2,3,2,1))
typeof(t)
attributes(t)

## What happens to a factor when you modify its levels?

f1 <- factor(letters)
levels(f1) <- rev(levels(f1))

## What does this code do? How do f2 and f3 differ from f1?

f2 <- rev(factor(letters))

f3 <- factor(letters, levels = rev(letters))


# Lists -------------------------------------------------------------------

## Why do you need to use unlist() to convert a list to an atomic vector? Why doesn’t as.vector() work?

l <- list(1,2,c(3,4))


# Data frames and tibbles -------------------------------------------------

df1 <- data.frame(x = 1:3, y = letters[1:3])

typeof(df1)
attributes(df1)

library(tibble)

df2 <- tibble(x = 1:3, y = letters[1:3])

typeof(df2)

attributes(df2)


dfm <- data.frame(
  x = 1:3 * 10
)
dfm$y <- matrix(1:9, nrow = 3)
dfm$z <- data.frame(a = 3:1, b = letters[1:3], stringsAsFactors = FALSE)

str(dfm)

## Can you have a data frame with zero rows? What about zero columns?

df3 <- data.frame()

## What happens if you attempt to set rownames that are not unique?

df4 <- data.frame(x = 1:3, row.names = c('a','a','b'))

## If df is a data frame, what can you say about t(df), and t(t(df))?
## Perform some experiments, making sure to try different column types.

df5 <- data.frame(a = 3:1, b = letters[1:3], stringsAsFactors = FALSE)
df5 <- data.frame(a = 3:1, b = 1:3)
t(df5)
t(t(df5))
typeof(t(t(df5)))

## What does as.matrix() do when applied to a data frame with columns of different types?
## How does it differ from data.matrix()?

as.matrix(df5)
data.matrix(df5)


