
<!-- README.md is generated from README.Rmd. Please edit that file -->

# faviconPlease

[![R-CMD-check](https://github.com/jdblischak/faviconPlease/workflows/R-CMD-check/badge.svg)](https://github.com/jdblischak/faviconPlease/actions)

Finds the URL to the favicon for a website. This is useful if you want
to display a website’s favicon in an HTML document or web application,
especially if the website is behind a firewall.

``` r
library(faviconPlease)
faviconPlease("https://github.com/")
```

    ## [1] "https://github.githubassets.com/favicons/favicon.svg"

## Installation

``` r
install.packages("remotes")
remotes::install_github("jdblischak/faviconPlease")
```

## Code of Conduct

Please note that the faviconPlease project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Default strategy

By default, `faviconPlease()` uses the following strategy to find the
URL to the favicon for a given website. It stops once it finds a URL and
returns it.

1.  Download the HTML file and search its `<head>` for any `<link>`
    elements with `rel="icon"` or `rel="shortcut icon"`.

2.  Download the HTML file at the root of the server (i.e. discard the
    path) and search its `<head>` for any `<link>` elements with
    `rel="icon"` or `rel="shortcut icon"`.

3.  Attempt to download a file called `favicon.ico` at the root of the
    server. This is the default location that a browser looks if the
    HTML file does not specify an alternative location in a `<link>`
    element. If the file `favicon.ico` is successfully downloaded, then
    this URL is returned.

4.  If the above steps fail, as a fallback, use the [favicon
    service](https://help.duckduckgo.com/duckduckgo-help-pages/features/favicons/)
    provided by the search engine [DuckDuckGo](https://duckduckgo.com/),
    e.g. <https://icons.duckduckgo.com/ip3/github.com.ico>. This
    provides a nice default for websites that don’t have a favicon (or
    can’t be easily found), e.g.
    <https://icons.duckduckgo.com/ip3/abc.ico>

## Extending faviconPlease

## Troubleshooting
