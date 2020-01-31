
# Base versus OO objects --------------------------------------------------

# A base object:
is.object(1:10)

sloop::otype(1:10)

# An OO object
is.object(mtcars)

sloop::otype(mtcars)

attr(mtcars,"class")

x <- matrix(1:4, nrow = 2)
class(x)
sloop::s3_class(x)


# Base types --------------------------------------------------------------

typeof(1L)
typeof(c(1,2,3))
