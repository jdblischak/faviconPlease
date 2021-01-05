source("tinytest-settings.R")
using("ttdo")

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
}
