# Contributing

## Development environment

Install the following development-only dependencies:

```
install.packages(c("devtools", "remotes", "rhub", "rmarkdown", "roxygen2"))
```

And then install the required and suggested dependencies:

```
remotes::install_deps(dependencies = TRUE)
```

## Generate the documentation

```
rmarkdown::render("README.Rmd")
roxygen2::roxygenize('.', roclets = c('rd', 'collate', 'namespace'))
```

## Run the tests

The tests use the [tinytest](https://cran.r-project.org/package=tinytest)
framework. The test files are in `/inst/tinytest/`.

```
# Run all tests
tinytest::test_all()
# Run a specific test file
tinytest::run_test_file("/inst/tinytest/<testfile>.R")
```

## Build and check the package

```
R CMD build --no-manual faviconPlease
R CMD check --timings --no-manual --as-cran faviconPlease_*.tar.gz
```

## Check the URLs

[CRAN checks the URLs in the documentation][cran-url-checks], including the
README. This is frustrating since it prevents you from discussing problematic
URLs, and there are also false positives. These generate a NOTE and thus will
delay the submission to CRAN. Check for problematic URLs with
[r-lib/urlchecker](https://github.com/r-lib/urlchecker).

```
remotes::install_github("r-lib/urlchecker")
urlchecker::url_check()
```

[cran-url-checks]: https://cran.r-project.org/web/packages/URL_checks.html

## Release to CRAN

1. Bump version to 3 components: major.minor.patch

1. Update `NEWS.md`

1. Check package with R-hub

    i. Validate email (once per machine)

        ```
        rhub::validate_email()
        ```

    i. Check on with R-release on Solaris

        ```
        rhub::check_for_cran(platform = "solaris-x86-patched")
        ```

    i. Check on with R-devel on Windows

        ```
        rhub::check_for_cran(platform = "windows-x86_64-devel")
        ```

1. Check package with R-devel on [win-builder][]

    ```
    devtools::check_win_devel()
    ```

    [win-builder]: https://win-builder.r-project.org/

1. Update `cran-comments.md`

1. [Submit tarball to CRAN](https://cran.r-project.org/submit.html)
