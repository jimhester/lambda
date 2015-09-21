#' Simple anonymous functions
#'
#' Function to create anonymous functions (lambdas) in a very concise manner.
#' Simply write the body of the function as you would normally.  If you want a
#' given variable to appear as one of the arguments to the function, put it in
#' \code{.()}.  Default arguments can be specified as you normally would in the
#' argument list.
#' @param expr Expression that is the body of the function
#' @param env the environment the new function will have
#' @examples
#' Reduce(f(.(x) + .(y)), 1:10)
#'
#' compact1 <- f(Filter(Negate(is.null(.(x)))))
#'
#' f(runif(n = rpois(1, 5), .(...)))
#' @export
f <- function(expr, env = parent.frame()) {

  if (missing(expr)) {
    stop("argument ", sQuote("expr"), " is missing, with no default", call. = FALSE)
  }

  args <- list()
  recurse <- function(e) {
    if (length(e) <= 1) e
    else if (e[[1]] == as.name(".")) {
      e <- e[-1]
      args <<- append(args, as.list(e))
      if (!is.null(names(e))) {
        as.symbol(names(e))
      } else {
        e[[1]]
      }
    } else {
      as.call(lapply(e, recurse))
    }
  }
  body <- recurse(substitute(expr))

  unnamed <- (if (!is.null(names(args))) names(args)
              else rep.int("", length(args))) == ""
  names(args)[unnamed] <- args[unnamed]
  args[unnamed] <- list(quote(expr=))

  eval(call("function", as.pairlist(args), body), env)
}
