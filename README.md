
<!-- README.md is generated from README.Rmd. Please edit that file -->
# faviconPlease

[![R-CMD-check](https://github.com/jdblischak/faviconPlease/workflows/R-CMD-check/badge.svg)](https://github.com/jdblischak/faviconPlease/actions)

Finds the URL to the favicon for a website. This is useful if you want to display a website's favicon in an HTML document or web application, especially if the website is behind a firewall.

``` r
library(faviconPlease)
faviconPlease("https://github.com/")
```

    ## [1] "https://github.githubassets.com/favicons/favicon.svg"
