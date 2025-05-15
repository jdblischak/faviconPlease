# Contributing

## Development environment

Install the following development-only dependencies:

```R
install.packages(c("devtools", "remotes", "rhub", "rmarkdown", "roxygen2"))
```

And then install the required and suggested dependencies:

```R
remotes::install_deps(dependencies = TRUE)
```

## Generate the documentation

```R
rmarkdown::render("README.Rmd")
roxygen2::roxygenize('.', roclets = c('rd', 'collate', 'namespace'))
```

## Run the tests

The tests use the [tinytest](https://cran.r-project.org/package=tinytest)
framework. The test files are in `inst/tinytest/`.

```R
# Run all tests
tinytest::test_all()
# Run a specific test file
tinytest::run_test_file("inst/tinytest/<testfile>.R")
```

## Build and check the package

```sh
R CMD build --no-manual faviconPlease
R CMD check --timings --no-manual --as-cran faviconPlease_*.tar.gz
```

## Check the URLs

[CRAN checks the URLs in the documentation][cran-url-checks], including the
README. This is frustrating since it prevents you from discussing problematic
URLs, and there are also false positives. These generate a NOTE and thus will
delay the submission to CRAN. Check for problematic URLs with
[r-lib/urlchecker](https://github.com/r-lib/urlchecker).

```R
remotes::install_github("r-lib/urlchecker")
urlchecker::url_check()
```

[cran-url-checks]: https://cran.r-project.org/web/packages/URL_checks.html

## Release to CRAN

1. Bump version to 3 components: major.minor.patch

1. Update `NEWS.md`

1. Check package with [R-hub v2][rhubv2]

    [rhubv2]: https://r-hub.github.io/rhub/articles/rhubv2.html


    1) Setup local machine. You need a [GitHub PAT][github-pat]

        ```R
        rhub::rhub_doctor()
        ```

        [github-pat]: https://gitcreds.r-lib.org/reference/gitcreds_get.html

    1) Check with R-devel on Ubuntu

        ```R
        rhub::rhub_check(platforms = "r-devel-linux-x86_64-debian-gcc")
        ```

    1) Check with R-devel on Windows

        ```R
        rhub::rhub_check(platforms = "r-devel-windows-x86_64")
        ```

1. Check package with R-devel on [win-builder][]

    ```R
    devtools::check_win_devel()
    ```

    [win-builder]: https://win-builder.r-project.org/

1. Update `cran-comments.md`

1. [Submit tarball to CRAN](https://cran.r-project.org/submit.html)

    ```sh
    R CMD build .
    ```

1. After acceptance, tag and create a release on GitHub

    ```sh
    git tag -l -n9
    git tag -a vX.X.X
    git push origin --tags
    ```

1. Bump to a development version: X.X.X.X
