


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
