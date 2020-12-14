library("faviconPlease")
library("tools")
utils::sessionInfo()

# Errors -----------------------------------------------------------------------

assertError(faviconPlease("www.r-project.org", functions = 1))

# faviconDuckDuckGo ------------------------------------------------------------

stopifnot(
  identical(
    faviconDuckDuckGo("address.domain"),
    "https://icons.duckduckgo.com/ip3/address.domain.ico"
  )
)

stopifnot(
  identical(
    faviconPlease("https://address.domain/path", functions = NULL),
    "https://icons.duckduckgo.com/ip3/address.domain.ico"
  )
)

# faviconGoogle ----------------------------------------------------------------

stopifnot(
  identical(
    faviconGoogle("address.domain"),
    "https://www.google.com/s2/favicons?domain_url=address.domain"
  )
)

stopifnot(
  identical(
    faviconPlease("https://address.domain/path", functions = NULL, fallback = faviconGoogle),
    "https://www.google.com/s2/favicons?domain_url=address.domain"
  )
)
