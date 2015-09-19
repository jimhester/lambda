#' Simple anonymous functions
#'
#' Function to create anonymous functions (lambdas) in a very concise manner.
#' Simply write the body of the function as you would normally.  If you want a
#' given variable to appear as one of the arguments to the function, put it in
#' \code{.()}.
#' @param expr Expression that is the body of the function
#' @param env the environment the new function will have
#' @examples
#' Reduce(f(.(x) + .(y)), 1:10)
#'
#' compact1 <- f(FilterNegate(is.null(.(x))))
#'
#' f(runif(n = rpois(1, 5), .(...)))
#' @export
f <- function(expr, env = parent.frame()) {
  args <- NULL
  recurse <- function(e) {
    if (length(e) <= 1) e
    else if (e[[1]] == as.name(".")) {
      args <<- append(args, e[[2]])
    e[[2]]
    } else {
      as.call(lapply(e, recurse))
    }
  }
  body <- recurse(substitute(expr))

  eval(call("function", as.pairlist(setNames(lapply(args, function(x) quote(expr=)), args)), body), env)
}
