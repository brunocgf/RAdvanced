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

## What happens when you subset a call object to remove the first element? e.g. expr(read.csv("foo.csv", header = TRUE))[-1]. Why?
expr(read.csv("foo.csv", header = TRUE))[-1]

## Describe the differences between the following call objects.

x <- 1:10
call2(median, x, na.rm = TRUE)
call2(expr(median), x, na.rm = TRUE)
call2(median, expr(x), na.rm = TRUE)
call2(expr(median), expr(x), na.rm = TRUE)

## Construct the expression if(x > 1) "a" else "b" using multiple calls to call2().
## How does the code structure reflect the structure of the AST?

call2("if",call2(">",expr(x),1),"a","b")


# Parsing and grammar -----------------------------------------------------

## R uses parentheses in two slightly different ways as illustrated by these two calls:
lobstr::ast(f((1)))
lobstr::ast(`(`(1 + 1))

!1 + !1

x1 <- x2 <- x3 <- 0

parse_expr("x + 1; y + 1")
parse_expr("a")
expr(a)


# Walking AST with recursive functions ------------------------------------

expr_type <- function(x) {
  if (rlang::is_syntactic_literal(x)) {
    "constant"
  } else if (is.symbol(x)) {
    "symbol"
  } else if (is.call(x)) {
    "call"
  } else if (is.pairlist(x)) {
    "pairlist"
  } else {
    typeof(x)
  }
}

switch_expr <- function(x, ...) {
  switch(expr_type(x),
         ...,
         stop("Don't know how to handle type ", typeof(x), call. = FALSE)
  )
}

recurse_call <- function(x) {
  switch_expr(x,
              # Base cases
              symbol = ,
              constant = ,
              
              # Recursive cases
              call = ,
              pairlist =
  )
}

logical_abbr_rec <- function(x) {
  switch_expr(x,
              constant = FALSE,
              symbol = as_string(x) %in% c("F", "T")
  )
}

logical_abbr <- function(x) {
  logical_abbr_rec(enexpr(x))
}

logical_abbr_rec <- function(x) {
  switch_expr(x,
              # Base cases
              constant = FALSE,
              symbol = as_string(x) %in% c("F", "T"),
              
              # Recursive cases
              call = ,
              pairlist = purrr::some(x, logical_abbr_rec)
  )
}

find_assign_rec <- function(x) {
  switch_expr(x,
              constant = ,
              symbol = character()
  )
}
find_assign <- function(x) find_assign_rec(enexpr(x))

flat_map_chr <- function(.x, .f, ...) {
  purrr::flatten_chr(purrr::map(.x, .f, ...))
}

flat_map_chr(letters[1:3], ~ rep(., sample(3, 1)))

find_assign_rec <- function(x) {
  switch_expr(x,
              # Base cases
              constant = ,
              symbol = character(),
              
              # Recursive cases
              pairlist = flat_map_chr(as.list(x), find_assign_rec),
              call = {
                if (is_call(x, "<-")) {
                  as_string(x[[2]])
                } else {
                  flat_map_chr(as.list(x), find_assign_rec)
                }
              }
  )
}

find_assign(a <- 1)

find_assign({
  a <- 1
  {
    b <- 2
  }
})

find_assign_call <- function(x) {
  if (is_call(x, "<-") && is_symbol(x[[2]])) {
    lhs <- as_string(x[[2]])
    children <- as.list(x)[-1]
  } else {
    lhs <- character()
    children <- as.list(x)
  }
  
  c(lhs, flat_map_chr(children, find_assign_rec))
}

find_assign_rec <- function(x) {
  switch_expr(x,
              # Base cases
              constant = ,
              symbol = character(),
              
              # Recursive cases
              pairlist = flat_map_chr(x, find_assign_rec),
              call = find_assign_call(x)
  )
}

