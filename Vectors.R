


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


