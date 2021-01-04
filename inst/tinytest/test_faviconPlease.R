using("ttdo")

# For ttdo output
options(
  diffobj.format = "ansi256",
  diffobj.mode = "unified"
)

# Placeholder with simple test
expect_equal_xl(1 + 1, 2)
