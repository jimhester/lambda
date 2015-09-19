<!-- README.md is generated from README.Rmd. Please edit that file -->
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
