library(sloop)


# Basics ------------------------------------------------------------------

f <- factor(c("a", "b", "c"))
typeof(f)
attributes(f)
unclass(f)

ftype(print)
ftype(str)

print(f)

time <- strptime(c("2017-01-01", "2020-05-04 03:21"), "%Y-%m-%d")
attributes(time)
str(time)
str(unclass(time))

s3_dispatch(print(f))

s3_get_method(weighted.mean.Date)

## What class of object does the following code return? What base type is it built on? What attributes does it use?

x <- ecdf(rpois(100, 10))
typeof(x)
attributes(x)
ftype(x)
unclass(x)

x <- table(rpois(100, 5))


# Classes -----------------------------------------------------------------

x <- structure(list(), class = "my_class")

x <- list()
class(x) <- "my_class"

new_Date <- function(x = double()) {
  stopifnot(is.double(x))
  structure(x, class = "Date")
}

new_Date(c(-1, 0, 1))

new_difftime <- function(x = double(), units = "secs") {
  stopifnot(is.double(x))
  units <- match.arg(units, c("secs", "mins", "hours", "days", "weeks"))
  
  structure(x,
            class = "difftime",
            units = units
  )
}

new_difftime(c(1, 10, 3600), "secs")

new_difftime(52, "weeks")

