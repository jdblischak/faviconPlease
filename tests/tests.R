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
      faviconIco("https", "www.genome.jp", "/kegg-bin/show_pathway"),
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

# Ensembl ----------------------------------------------------------------------

# ensembl.org is interesting for multiple reasons:
#   * It can't be read with xml2::read_html() b/c its SSL certificate is
#     invalid. I assume this has to do with how it redirects to
#     https://useast.ensembl.org. By default method="libcurl",
#     getOption("download.file.method"), uses -L to folow redirects, so I don't
#     know what the exact problem is.
#   * It has a rel="icon" link in addition to /favicon.ico, and it points to a
#     a different path: /i/ensembl-favicon.png
#   * The links in its head element are duplicated
if (hasInternet) {
  stopifnot(
    identical(
      faviconLink("https", "ensembl.org", "/Homo_sapiens/Gene/Summary"),
      "https://ensembl.org/i/ensembl-favicon.png"
    )
  )

  # So far I could only get the favicon.ico with utils::download.file() with
  # `wget --no-check-certificate`
  if (Sys.which("wget") != "") {
    stopifnot(
      identical(
        faviconIco("https", "ensembl.org", "/Homo_sapiens/Gene/Summary",
                   method = "wget", extra = "--no-check-certificate"),
        "https://ensembl.org/favicon.ico"
      )
    )
  } else {
    message("wget is not available")
  }

  stopifnot(
    identical(
      faviconPlease("https://ensembl.org/Homo_sapiens/Gene/Summary?g="),
      "https://ensembl.org/i/ensembl-favicon.png"
    )
  )
}
