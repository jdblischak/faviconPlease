source("tinytest-settings.R")
using("ttdo")

expect_identical_xl(
  faviconDuckDuckGo("address.domain"),
  "https://icons.duckduckgo.com/ip3/address.domain.ico"
)

expect_identical_xl(
  faviconPlease("https://address.domain/path", functions = NULL),
  "https://icons.duckduckgo.com/ip3/address.domain.ico"
)
