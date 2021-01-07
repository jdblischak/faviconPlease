source("tinytest-settings.R")
using("ttdo")

# ensembl.org is interesting for multiple reasons:
#   * It can't be read with xml2::read_html() b/c its SSL certificate is
#     invalid. I assume this has to do with how it redirects to
#     https://useast.ensembl.org. By default method="libcurl",
#     getOption("download.file.method"), uses -L to follow redirects, so I don't
#     know what the exact problem is.
#   * It has a rel="icon" link in addition to /favicon.ico, and it points to a
#     a different path: /i/ensembl-favicon.png
#   * The links in its head element are duplicated

if (at_home()) {
  expect_identical_xl(
    faviconLink("https", "ensembl.org", "/Homo_sapiens/Gene/Summary"),
    "https://ensembl.org/i/ensembl-favicon.png"
  )

  # So far I could only get the favicon.ico with utils::download.file() with
  # `wget --no-check-certificate`
  if (Sys.which("wget") != "") {
    os <- utils::osVersion
    # Ubuntu 20.04 (focal) requires extra security settings, but the argument
    # --ciphers isn't available for the version of wget on Ubuntu 18.04
    # (bionic).
    # https://stackoverflow.com/a/62359497
    if (startsWith(os, "Ubuntu 20")) {
      # apex domain
      expect_identical_xl(
        faviconIco("https", "ensembl.org", "/Homo_sapiens/Gene/Summary",
                   method = "wget", extra = c("--no-check-certificate",
                                              "--ciphers=DEFAULT:@SECLEVEL=1")),
        "https://ensembl.org/favicon.ico"
      )
      # www subdomain
      expect_identical_xl(
        faviconIco("https", "www.ensembl.org", "/Homo_sapiens/Gene/Summary",
                   method = "wget", extra = c("--no-check-certificate",
                                              "--ciphers=DEFAULT:@SECLEVEL=1")),
        "https://www.ensembl.org/favicon.ico"
      )
    } else {
      # apex domain
      expect_identical_xl(
        faviconIco("https", "ensembl.org", "/Homo_sapiens/Gene/Summary",
                   method = "wget", extra = "--no-check-certificate"),
        "https://ensembl.org/favicon.ico"
      )
      # www subdomain
      expect_identical_xl(
        faviconIco("https", "www.ensembl.org", "/Homo_sapiens/Gene/Summary",
                   method = "wget", extra = "--no-check-certificate"),
        "https://www.ensembl.org/favicon.ico"
      )
    }
  } else {
    message("wget is not available")
  }

  expect_identical_xl(
    faviconPlease("https://ensembl.org/Homo_sapiens/Gene/Summary?g="),
    "https://ensembl.org/i/ensembl-favicon.png"
  )
}

# uniprot.org is also owned by EBI, so it suffers from the same complications
# caused by Ubuntu 20's increased security settings.
# https://github.com/Ensembl/ensembl-rest/issues/427#issuecomment-629268281

if (at_home()) {
  # <link type="image/vnd.microsoft.icon" href="/favicon.ico" rel="shortcut icon"/>
  expect_identical_xl(
    faviconLink("https", "www.uniprot.org", "/uniprot/"),
    "https://www.uniprot.org/favicon.ico"
  )

  # So far I could only get the favicon.ico with utils::download.file() with
  # `wget --no-check-certificate`
  if (Sys.which("wget") != "") {
    os <- utils::osVersion
    # Ubuntu 20.04 (focal) requires extra security settings, but the argument
    # --ciphers isn't available for the version of wget on Ubuntu 18.04
    # (bionic).
    # https://stackoverflow.com/a/62359497
    if (startsWith(os, "Ubuntu 20")) {
      expect_identical_xl(
        faviconIco("https", "www.uniprot.org", "/uniprot/",
                   method = "wget", extra = c("--no-check-certificate",
                                              "--ciphers=DEFAULT:@SECLEVEL=1")),
        "https://www.uniprot.org/favicon.ico"
      )
    } else {
      expect_identical_xl(
        faviconIco("https", "www.uniprot.org", "/uniprot/",
                   method = "wget", extra = "--no-check-certificate"),
        "https://www.uniprot.org/favicon.ico"
      )
    }
  } else {
    message("wget is not available")
  }

  expect_identical_xl(
    faviconPlease("https://www.uniprot.org/uniprot/"),
    "https://www.uniprot.org/favicon.ico"
  )
}
