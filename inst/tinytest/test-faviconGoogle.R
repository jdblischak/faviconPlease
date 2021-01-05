source("tinytest-settings.R")
using("ttdo")

expect_identical_xl(
  faviconGoogle("address.domain"),
  "https://www.google.com/s2/favicons?domain_url=address.domain"
)

expect_identical_xl(
  faviconPlease("https://address.domain/path", functions = NULL, fallback = faviconGoogle),
  "https://www.google.com/s2/favicons?domain_url=address.domain"
)
