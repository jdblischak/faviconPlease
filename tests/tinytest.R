# See inst/tinytest/ for test files

# Check internet connection (only works on unix-alike)
checkInternet <- function(site = "www.r-project.org") {
  os <- .Platform$OS.type
  if (os == "windows") {
    return(NA)
  }
  hasInternet <- !is.null(suppressWarnings(utils::nsl(site)))
  if (!hasInternet) message("No internet connection")
  return(invisible(hasInternet))
}
checkInternet()

if (requireNamespace("tinytest", quietly = TRUE)){
  tinytest::test_package("faviconPlease", at_home = FALSE)
}
# To run the at_home tests, run tinytest::test_all()
