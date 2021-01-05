source("tinytest-settings.R")
using("ttdo")

if (at_home()) {
  expect_identical_xl(
    faviconIco("https", "www.genome.jp", "/kegg-bin/show_pathway"),
    "https://www.genome.jp/favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("https://www.genome.jp/kegg-bin/show_pathway?map00410"),
    "https://www.genome.jp/favicon.ico"
  )

  expect_identical_xl(
    faviconIco("https", "www.phosphosite.org", ""),
    "https://www.phosphosite.org/favicon.ico"
  )

  expect_identical_xl(
    faviconPlease("https://www.phosphosite.org/"),
    "https://www.phosphosite.org/favicon.ico"
  )

  expect_identical_xl(
    faviconIco("http", "www.informatics.jax.org", "/searchtool/Search.do?query="),
    "http://www.informatics.jax.org/favicon.ico"
  )

  expect_identical_xl(
    faviconIco("https", "www.ncbi.nlm.nih.gov",
               "/CCDS/CcdsBrowse.cgi?REQUEST=CCDS&ORGANISM=9606&BUILDS=CURRENTBUILDS&DATA="),
    "https://www.ncbi.nlm.nih.gov/favicon.ico"
  )

  expect_identical_xl(
    faviconIco("https", "www.uniprot.org", "/uniprot/"),
    "https://www.uniprot.org/favicon.ico"
  )
}
