library(rlang)
library(purrr)

# Motivation --------------------------------------------------------------

cement <- function(...) {
  args <- ensyms(...)
  paste(purrr::map(args, as_string), collapse = " ")
}


# Quoting -----------------------------------------------------------------

substitute(x * y * z, list(x = 10, y = expr(a + b)))

## How is expr() implemented? Look at its source code.
expr
enexpr

## Compare and contrast the following two functions. Can you predict the output before running them?
f1 <- function(x, y) {
  exprs(x = x, y = y)
}
f2 <- function(x, y) {
  enexprs(x = x, y = y)
}
f1(a + b, c + d)
f2(a + b, c + d)



# Unquoting ---------------------------------------------------------------

x <- expr(-1)
expr(f(!!x, y))

## Given the following components:

xy <- expr(x + y)
xz <- expr(x + z)
yz <- expr(y + z)
abc <- exprs(a, b, c)

## Use quasiquotation to construct the following calls:

expr(!!xy/!!yz)
(x + y) / (y + z)

expr(`^`(!!-xz,!!yz))
-(x + z) ^ (y + z)

expr(!!xy + !!yz - !!xy)
(x + y) + (y + z) - (x + y)


# ... (dot-dot-dot) -------------------------------------------------------

dfs <- list(
  a = data.frame(x = 1, y = 2),
  b = data.frame(x = 3, y = 4)
)

dplyr::bind_rows(!!!dfs)
dplyr::bind_rows(dfs)

# Directly
exec("mean", x = 1:10, na.rm = TRUE, trim = 0.1)

# Indirectly
args <- list(x = 1:10, na.rm = TRUE, trim = 0.1)
exec("mean", !!!args)

# Mixed
params <- list(na.rm = TRUE, trim = 0.1)
exec("mean", x = 1:10, !!!params)

do.call("rbind", dfs)
