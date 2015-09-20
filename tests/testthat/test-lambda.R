context("f")
test_that("f throws error without a body", {
  expect_error(f(), "argument.*is missing, with no default")
})

test_that("f matches functions", {

  expect_equal(f({}), function() {})

  expect_equal(f(5), function() 5)

  expect_equal(f(.(x)), function(x) x)

  expect_equal(f(.(x) + .(y)), function(x, y) x + y)

  expect_equal(f(.(x) + .(y = 5)), function(x, y = 5) x + y)

  expect_equal(f(plot(.(x), .(...))), function(x, ...) plot(x, ...))

  expect_equal(f(.(x) + .(y = x + 1)), function(x, y = x + 1) x + y)
})
