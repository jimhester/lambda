<!-- README.md is generated from README.Rmd. Please edit that file -->
Lambda
======

[![Travis-CI Build Status](https://travis-ci.org/jimhester/lambda.svg?branch=master)](https://travis-ci.org/jimhester/lambda) [![Coverage Status](https://img.shields.io/codecov/c/github/jimhester/lambda/master.svg)](https://codecov.io/github/jimhester/lambda?branch=master)

Lambda contains only one function `f()`, which allows you to write new functions in a very compact format.

Simply write the body of the function as you would normally. If you want a given variable to appear as one of the arguments to the function, surround it with `.()`. Default arguments can be also be specified within `.()` as you normally would in the argument list.

``` r
library(lambda)

function(x, y) x + y
#> function(x, y) x + y
f(.(x) + .(y))
#> function (x, y) 
#> x + y

Reduce(f(.(x) + .(y)), 1:10)
#> [1] 55

add <- f(.(x) + .(y = 5))
add
#> function (x, y = 5) 
#> x + y

add(1)
#> [1] 6

add(1, 2)
#> [1] 3
```

It works very well as a way to compactly define simple utility functions

``` r
x <- list(1, list(NULL), 2)
compact <- f(Filter(Negate(is.null), .(x)))
compact
#> function (x) 
#> Filter(Negate(is.null), x)
compact(x)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [[2]][[1]]
#> NULL
#> 
#> 
#> [[3]]
#> [1] 2
```

Or for partial function application

``` r
f1 <- f(runif(n = rpois(1, 5), .(...)))
f1
#> function (...) 
#> runif(n = rpois(1, 5), ...)
```

References
----------

For a different (better?) approach to this same idea, see [pryr::f()](https://github.com/hadley/pryr/blob/master/R/f.r).
