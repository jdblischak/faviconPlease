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
}
