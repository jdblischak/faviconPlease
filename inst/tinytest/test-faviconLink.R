source("tinytest-settings.R")
using("ttdo")

useFileProtocol <- function(filepath) {
  paste0("file://", normalizePath(filepath))
}

fileNoLink <- useFileProtocol("testFiles/no-link.html")

expect_identical_xl(
  faviconPlease(fileNoLink, functions = list(faviconLink), fallback = ""),
  "",
  info = "No link"
)

fileAbsolute <- useFileProtocol("testFiles/absolute.html")

expect_identical_xl(
  faviconPlease(fileAbsolute, functions = list(faviconLink), fallback = ""),
  "https://absolute.com/custom.png",
  info = "Absolute link"
)

fileProtocolRelative <- useFileProtocol("testFiles/protocol-relative.html")

expect_identical_xl(
  faviconPlease(fileProtocolRelative, functions = list(faviconLink), fallback = ""),
  "file://protocol-relative.com/custom.png",
  info = "Protocol-relative link"
)

fileRootRelative <- useFileProtocol("testFiles/root-relative.html")

expect_identical_xl(
  faviconPlease(fileRootRelative, functions = list(faviconLink), fallback = ""),
  "file:///root-relative/custom.png",
  info = "Root-relative link"
)

fileRootRelativeWithBase <- useFileProtocol("testFiles/root-relative-with-base.html")

expect_identical_xl(
  faviconPlease(fileRootRelativeWithBase, functions = list(faviconLink), fallback = ""),
  "file:///root-relative/custom.png",
  info = "Root-relative link with base"
)

fileRelative <- useFileProtocol("testFiles/relative.html")
iconRelativeExpected <- file.path(dirname(fileRelative), "custom.png")

expect_identical_xl(
  suppressWarnings(
    faviconPlease(fileRelative, functions = list(faviconLink), fallback = "")
  ),
  iconRelativeExpected,
  info = "Relative link"
)

# Examples ---------------------------------------------------------------------

if (at_home()) {
  # Example of absolute link with rel="icon"
  expect_identical_xl(
    faviconLink("https", "stephenslab.github.io", "/wflow-divvy/"),
    "https://github.com/workflowr/workflowr-assets/raw/master/img/reproducible.png"
  )

  expect_identical_xl(
    faviconPlease("https://stephenslab.github.io/wflow-divvy/"),
    "https://github.com/workflowr/workflowr-assets/raw/master/img/reproducible.png"
  )

  # Example of root-relative link with rel="shortcut icon"
  expect_identical_xl(
    faviconLink("https", "reactome.org", "/content/detail/R-HSA-983712"),
    "https://reactome.org/templates/favourite/favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("https://reactome.org/content/detail/R-HSA-983712"),
    "https://reactome.org/templates/favourite/favicon.ico"
  )

  # Example of a partial URL that gives a 404. Solved by reading the HTML for the
  # base URL.
  expect_identical_xl(
    faviconLink("http", "amigo.geneontology.org", "/amigo/term/"),
    "http://amigo.geneontology.org/static/images/go-logo-favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("http://amigo.geneontology.org/amigo/term/"),
    "http://amigo.geneontology.org/static/images/go-logo-favicon.ico"
  )

  # Example of a protocol-relative URL
  # https://en.wikipedia.org/wiki/URL#prurl
  # https://stackoverflow.com/a/9646435
  expect_identical_xl(
    faviconLink("https", "www.ncbi.nlm.nih.gov", "/gene/"),
    "https://www.ncbi.nlm.nih.gov/favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("https://www.ncbi.nlm.nih.gov/gene/"),
    "https://www.ncbi.nlm.nih.gov/favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("http://www.ncbi.nlm.nih.gov/gene/"),
    "http://www.ncbi.nlm.nih.gov/favicon.ico"
  )

  # Example with <base>
  expect_identical(
    faviconLink("https", "www.gsea-msigdb.org", "/gsea/msigdb/cards/"),
    "https://www.gsea-msigdb.org/gsea/images/icon_32x32.png"
  )

  expect_identical(
    faviconPlease("https://www.gsea-msigdb.org/gsea/msigdb/cards/"),
    "https://www.gsea-msigdb.org/gsea/images/icon_32x32.png"
  )

  # Example of multiple rel="icon" (multiple sizes). The first one is always
  # returned. The link is site-relative.
  expect_identical(
    faviconLink("https", "www.r-project.org", "/"),
    "https://www.r-project.org/favicon-32x32.png"
  )

  expect_identical(
    faviconPlease("https://www.r-project.org/"),
    "https://www.r-project.org/favicon-32x32.png"
  )

  # Example of rel="icon" with absolute link
  expect_identical(
    faviconLink("https", "github.com", "/jdblischak/faviconPlease"),
    "https://github.githubassets.com/favicons/favicon.svg"
  )

  expect_identical(
    faviconPlease("https://github.com/jdblischak/faviconPlease"),
    "https://github.githubassets.com/favicons/favicon.svg"
  )
}
