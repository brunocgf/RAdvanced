library(rlang)
library(lobstr)


# Abstract syntax trees ---------------------------------------------------

lobstr::ast(f(x, "y", 1))
lobstr::ast(f(g(1, 2), h(3, 4, i())))
lobstr::ast(y <- x * 10)


# Expressions -------------------------------------------------------------

identical(expr(TRUE), TRUE)
identical(expr(1), 1)
identical(expr(2L), 2L)
identical(expr("x"), "x")

expr(x)
sym("x")

as_string(expr(x))
as.character(expr(x))

lobstr::ast(read.table("important.csv", row.names = FALSE))
x <- expr(read.table("important.csv", row.names = FALSE))

typeof(x)
is.call(x)

x[[3]]
is.symbol(x[[1]])

call2("mean", x = expr(x), na.rm = TRUE)

call2(expr(base::mean), x = expr(x), na.rm = TRUE)

