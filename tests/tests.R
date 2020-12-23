library("faviconPlease")
library("tools")
utils::sessionInfo()

checkInternet <- function(site = "www.r-project.org") {
  .Platform$OS.type == "unix" && !is.null(suppressWarnings(utils::nsl(site)))
}
hasInternet <- checkInternet()
if (!hasInternet) message("No internet connection")

# Errors -----------------------------------------------------------------------

# Invalid links
assertError(faviconPlease(1))

# Invalid functions
assertError(faviconPlease("https://www.r-project.org", functions = 1))

# Invalid fallback
assertError(faviconPlease("https://www.r-project.org/", fallback = 1))
assertError(faviconPlease("https://www.r-project.org/", fallback = c("a", "b")))
assertError(faviconPlease("https://www.r-project.org/", fallback = function(x, y) 1))

# faviconLink ------------------------------------------------------------------

if (hasInternet) {
  # Example of absolute link with rel="icon"
  stopifnot(
    identical(
      faviconLink("https", "stephenslab.github.io", "/wflow-divvy/"),
      "https://github.com/workflowr/workflowr-assets/raw/master/img/reproducible.png"
    )
  )

  stopifnot(
    identical(
      faviconPlease("https://stephenslab.github.io/wflow-divvy/"),
      "https://github.com/workflowr/workflowr-assets/raw/master/img/reproducible.png"
    )
  )

  # Example of root-relative link with rel="shortcut icon"
  stopifnot(
    identical(
      faviconLink("https", "reactome.org", "/content/detail/R-HSA-983712"),
      "https://reactome.org/templates/favourite/favicon.ico"
    )
  )

  stopifnot(
    identical(
      faviconPlease("https://reactome.org/content/detail/R-HSA-983712"),
      "https://reactome.org/templates/favourite/favicon.ico"
    )
  )
}

# faviconIco -------------------------------------------------------------------

if (hasInternet) {
  stopifnot(
    identical(
      faviconIco("https", "www.genome.jp", "/kegg-bin/show_pathway?map00410"),
      "https://www.genome.jp/favicon.ico"
    )
  )

  stopifnot(
    identical(
      faviconPlease("https://www.genome.jp/kegg-bin/show_pathway?map00410"),
      "https://www.genome.jp/favicon.ico"
    )
  )

  stopifnot(
    identical(
      faviconIco("https", "www.phosphosite.org", ""),
      "https://www.phosphosite.org/favicon.ico"
    )
  )

  stopifnot(
    identical(
      faviconPlease("https://www.phosphosite.org/"),
      "https://www.phosphosite.org/favicon.ico"
    )
  )
}

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
