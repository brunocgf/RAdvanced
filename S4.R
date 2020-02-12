
# Basics ------------------------------------------------------------------

setClass("Person", 
         slots = c(
           name = "character", 
           age = "numeric"
         )
)

john <- new("Person", name = "John Smith", age = NA_real_)

## lubridate::period() returns an S4 class. What slots does it have? What class is each slot? What accessors does it provide?

x <- lubridate::period(1)

x@year


# S4 and S3 ---------------------------------------------------------------

setOldClass("data.frame")
setOldClass(c("ordered", "factor"))
setOldClass(c("glm", "lm"))
