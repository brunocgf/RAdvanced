library(lobstr)

# Binding Basics ----------------------------------------------------------

x <- c(1, 2, 3)
y <- x

obj_addr(x)
obj_addr(y)

?Reserved ## reserved words


## Explain the relationship between a, b, c and d in the following code:

a <- 1:10
b <- a
c <- b
d <- 1:10

obj_addr(a)
obj_addr(b)
obj_addr(c)
obj_addr(d)

## The following code accesses the mean function in multiple ways.
## Do they all point to the same underlying function object? Verify this with lobstr::obj_addr()

mean
base::mean
get("mean")
evalq(mean)
match.fun("mean")

obj_addr(mean)
obj_addr(base::mean)
obj_addr(get("mean"))
obj_addr(evalq(mean))
obj_addr(match.fun("mean"))

## What rules does make.names() use to convert non-syntactic names into syntactic ones?


# Copy-on-modify ----------------------------------------------------------

x <- c(1, 2, 3)
y <- x

y[[3]] <- 4
x

## Explain why tracemem() shows two copies when you run this code.

x <- c(1L, 2L, 3L)
tracemem(x)

x[[3]] <- 4

## What happens when you run this code?

x <- list(1:10)
x[[2]] <- x


# Object size -------------------------------------------------------------

## Predict the output of the following code:

a <- runif(1e6)
obj_size(a)

b <- list(a, a)
obj_size(b)
obj_size(a, b)

b[[1]][[1]] <- 10
obj_size(b)
obj_size(a, b)

b[[2]][[1]] <- 10
obj_size(b)
obj_size(a, b)


