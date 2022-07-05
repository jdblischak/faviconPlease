source("tinytest-settings.R")
using("ttdo")

if (!at_home()) exit_file("Only test ensembl \"at_home\"")

# EBI sites like Ensembl and UniProt are critical for OmicNavigator, but can be
# extremely flaky due to SSL certificate issues, redirecting to mirrors, and
# differences in the HTML <head> between the mirrors

# useast.ensembl.org -----------------------------------------------------------

# https://useast.ensembl.org/
#
# <link type="image/png" href="/i/ensembl-favicon.png" rel="icon" />

expect_identical_xl(
  basename(
    faviconLink("https", "useast.ensembl.org", "/Homo_sapiens/Gene/Summary")
  ),
  "ensembl-favicon.png"
)

expect_identical_xl(
  basename(
    faviconPlease("https://useast.ensembl.org/Homo_sapiens/Gene/Summary?g=")
  ),
  "ensembl-favicon.png"
)

# www.ensembl.org --------------------------------------------------------------

# https://www.ensembl.org/?redirect=no
#
# <link type="image/png" rel="icon" href="//static.ensembl.org/i/ensembl-favicon.png" />

# The browser clearly shows the URL "//static.ensembl.org/i/ensembl-favicon.png".
# And this works on my personal laptop. But on GitHub Actions and my work
# laptop, it somehow returns "/i/ensembl-favicon.png". I haven't been able to
# figure out the source of the discrepancy, and at the end of the day, it
# doesn't matter as long as it returns a valid favicon path

expect_identical_xl(
  basename(
    faviconLink("https", "ensembl.org", "/Homo_sapiens/Gene/Summary")
  ),
  "ensembl-favicon.png"
)

expect_identical_xl(
  basename(
    faviconPlease("https://ensembl.org/Homo_sapiens/Gene/Summary?g=")
  ),
  "ensembl-favicon.png"
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

# uniprot.org ------------------------------------------------------------------

# uniprot.org is also owned by EBI, so it suffers from the same complications
# caused by Ubuntu 20's increased security settings.
# https://github.com/Ensembl/ensembl-rest/issues/427#issuecomment-629268281


# <link type="image/vnd.microsoft.icon" href="/favicon.ico" rel="shortcut icon"/>
expect_identical_xl(
  faviconLink("https", "www.uniprot.org", "/uniprot/"),
  "https://www.uniprot.org/favicon-32x32.png"
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
  "https://www.uniprot.org/favicon-32x32.png"
)
