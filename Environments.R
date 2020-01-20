library(rlang)

# Environment basics ------------------------------------------------------
e1 <- env(
  a = FALSE,
  b = "a",
  c = 2.3,
  d = 1:3,
)

e1$d <- e1
env_print(e1)

## Create an environment as illustrated by this picture.

e2 <- env()
e2$loop <- e2


# Recursing over environments ---------------------------------------------

where <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    # Base case
    stop("Can't find ", name, call. = FALSE)
  } else if (env_has(env, name)) {
    # Success case
    env
  } else {
    # Recursive case
    where(name, env_parent(env))
  }
}

where("yyy")

x <- 5
where("x")

where("mean")

## Modify where() to return all environments that contain a binding for name.
## Carefully think through what type of object the function will need to return.

where2 <- function(name, env = caller_env()){
  if (identical(env, empty_env())){
    # Base case
    stop("Can't find ", name, call. = FALSE)
    }
  
  else {
    # Success case
    if (env_has(env, name)) {print(env)}
    where2(name, env_parent(env))
  }
}

where2("yyy")

x <- 5
where2("x")

where("mean")


# Special environments ----------------------------------------------------

env_parent(base_env())

h2 <- function(x) {
  a <- x * 2
  current_env()
}

e <- h2(x = 10)
env_print(e)

fn_env(h2)

## How is search_envs() different from env_parents(global_env())?

search_env(global_env())
env_parents(global_env())


# Call stacks -------------------------------------------------------------


