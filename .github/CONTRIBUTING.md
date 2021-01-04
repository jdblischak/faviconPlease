# Contributing

## Tests

The tests use the [tinytest](https://cran.r-project.org/package=tinytest)
framework. The test files are in `/inst/tinytest/`.

```
# Run all tests
tinytest::test_all()
# Run a specific test file
tinytest::run_test_file("/inst/tinytest/<testfile>.R")
```
