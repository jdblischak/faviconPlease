### Development version (GitHub)

* Add a default timeout of 2 seconds when attempting to access a page via {httr}
  (done by `faviconLink()` if {httr} is installed). This can be modified by the
  new package option `FAVICONPLEASE_TIMEOUT_SECONDS`. It must be an integer
  (suffix of `L`).

### 0.1.4

* Minor maintenance release

### 0.1.3

* Only define the curl option `ssl_cipher_list = "DEFAULT@SECLEVEL=1"` on Linux.
  It's original purpose was to get around the increased security level on Ubuntu
  20.04. But now it is causing failures on macOS and Windows
* Update tests for uniprot.org and amigo.geneontology.org

### 0.1.2

* Remove problematic URLs and link to blog post
* Update tests for ensembl.org

### 0.1.1

* Document return value for `faviconPlease()`

### 0.1.0

* Initial release
