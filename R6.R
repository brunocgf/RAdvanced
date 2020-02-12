library(R6)


# Classes and methods -----------------------------------------------------

Accumulator <- R6Class("Accumulator", list(
  sum = 0,
  add = function(x = 1) {
    self$sum <- self$sum + x 
    invisible(self)
  })
)

x <- Accumulator$new()

x$add(4)
x$sum

Person <- R6Class("Person", list(
  name = NULL,
  age = NA,
  initialize = function(name, age = NA) {
    stopifnot(is.character(name), length(name) == 1)
    stopifnot(is.numeric(age), length(age) == 1)
    
    self$name <- name
    self$age <- age
  }
))

hadley <- Person$new("Hadley", age = "thirty-eight")
hadley <- Person$new("Hadley", age = 38)


## Create a bank account R6 class that stores a balance and allows you to deposit and withdraw money.
## Create a subclass that throws an error if you attempt to go into overdraft.
## Create another subclass that allows you to go into overdraft, but charges you a fee.

Balance <- R6Class("Balance",list(
  balance = 0,
  deposit = function(x){
    self$balance <- self$balance + x
    invisible(self)
  },
  withdraw = function(x){
    self$balance <- self$balance - x
    invisible(self)
  }
))


# Controlling access ------------------------------------------------------

## Create a bank account class that prevents you from directly setting the account balance,
## but you can still withdraw from and deposit to. Throw an error if you attempt to go into overdraft.

Balance <- R6Class("Balance",
                   private = list(
                     .balance = 0
                   ),
                   active = list(
                     balance = function(value){
                       if(missing(value)){
                         private$.balance
                       }
                       else {
                         stop("`$balance` is read only", call. = FALSE)
                       }
                     }
                   ),
                   public = list(
                     deposit = function(x){
                       private$.balance <- private$.balance + x
                       invisible(self)
                       },
                     withdraw = function(x){
                       private$.balance <- private$.balance - x
                       invisible(self)
                       }
                     )
                   )

