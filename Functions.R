
# Function fundamentals ---------------------------------------------------


f02 <- function(x, y) {
  # A comment
  x + y
}

formals(f02)
body(f02)
environment(f02)
attr(f02, "srcref")

f01 <- function(x) {
  sin(1 / x ^ 2)
}

## Given a name, like "mean", match.fun() lets you find a function.
## Given a function, can you find its name? Why doesn’t that make sense in R?

match.fun('mean')

## It’s possible (although typically not useful) to call an anonymous function.
## Which of the two approaches below is correct? Why?

function(x) 3()

(function(x) 3)()

## A good rule of thumb is that an anonymous function should fit on one line and shouldn’t need to use {}.
## Review your code. Where could you have used an anonymous function instead of a named function?
## Where should you have used a named function instead of an anonymous function?

## What function allows you to tell if an object is a function?
## What function allows you to tell if a function is a primitive function?

typeof(f01)
typeof(sum)


## This code makes a list of all functions in the base package.

objs <- mget(ls("package:base", all = TRUE), inherits = TRUE)
funs <- Filter(is.function, objs)

## Which base function has the most arguments?

a <- sapply(funs, function(f){length(formals(f))})
a[a==max(a)]

## How many base functions have no arguments? What’s special about those functions?
a[a==0]


# Function composition ----------------------------------------------------

square <- function(x) x^2
deviation <- function(x) x - mean(x)
x <- runif(100)

library(magrittr)

x %>%
  deviation() %>%
  square() %>%
  mean() %>%
  sqrt()


# Lexical scoping ---------------------------------------------------------

x <- 10
g01 <- function() {
  x <- 20
  x
}

g01()

x <- 1
g04 <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i()
}
g04()

g11 <- function() {
  if (!exists("a")) {
    a <- 1
  }
  else {
    a <- a + 1
  }
  a
}

g11()
g11()

## What does the following code return? Why? Describe how each of the three c’s is interpreted.
c <- 10
c(c = c)

## What does the following function return? Make a prediction before running the code yourself.
f <- function(x) {
  f <- function(x) {
    f <- function() {
      x ^ 2
    }
    f() + 1
  }
  f(x) * 2
}
f(10)


# Lazy evaluation ---------------------------------------------------------

## What does this function return? Why? Which principle does it illustrate?

f2 <- function(x = z) {
  z <- 100
  x
}
f2()

## What does this function return? Why? Which principle does it illustrate?

y <- 10
f1 <- function(x = {y <- 1; 2}, y = 0) {
  c(x, y)
}
f1()
y

## Explain why this function works. Why is it confusing?

show_time <- function(x = stop("Error!")) {
  stop <- function(...) Sys.time()
  print(x)
}
show_time()


# ... (dot-dot-dot) -------------------------------------------------------

## Explain the following results:

sum(1, 2, 3)
mean(1, 2, 3)
sum(1, 2, 3, na.omit = TRUE)
mean(1, 2, 3, na.omit = TRUE)

## Explain how to find the documentation for the named arguments in the following function call:

plot(1:10, col = "red", pch = 20, xlab = "x", col.lab = "blue")


# Exiting a function ------------------------------------------------------

cleanup <- function(dir, code) {
  old_dir <- setwd(dir)
  on.exit(setwd(old_dir), add = TRUE)
  
  old_opt <- options(stringsAsFactors = FALSE)
  on.exit(options(old_opt), add = TRUE)
}

## What does load() return? Why don’t you normally see these values?
?load
load(mtcars)

capture.output2 <- function(code) {
  temp <- tempfile()
  on.exit(file.remove(temp), add = TRUE, after = TRUE)
  
  sink(temp)
  on.exit(sink(), add = TRUE, after = TRUE)
  
  force(code)
  readLines(temp)
}
x <- capture.output2(cat("a", "b", "c", sep = "\n"))
y <- capture.output(cat("a", "b", "c", sep = "\n"))


# Function forms ----------------------------------------------------------

`<-`(x,2)

x + y
`+`(x, y)

names(df) <- c("x", "y", "z")
`names<-`(df, c("x", "y", "z"))

for(i in 1:10) print(i)
`for`(i, 1:10, print(i))


