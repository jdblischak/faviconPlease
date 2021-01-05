source("tinytest-settings.R")
using("ttdo")

# Invalid links
expect_error_xl(
  faviconPlease(1),
  "The argument `links` must be a character vector of URLs"
)

# Invalid functions
expect_error_xl(
  faviconPlease("https://www.r-project.org", functions = 1),
  "The argument `functions` must be a list of functions or NULL"
)

# Invalid fallback
expect_error_xl(
  faviconPlease("https://www.r-project.org/", fallback = 1),
  "The argument `fallback` must be a function with one argument or a single character string"
)

expect_error_xl(
  faviconPlease("https://www.r-project.org/", fallback = c("a", "b")),
  "The argument `fallback` must be a function with one argument or a single character string"
)

expect_error_xl(
  faviconPlease("https://www.r-project.org/", fallback = function(x, y) 1),
  "The argument `fallback` must be a function with one argument or a single character string"
)
