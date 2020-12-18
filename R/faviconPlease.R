#' Find the URL to a website's favicon
#'
#' @export
faviconPlease <- function(
  links,
  functions = list(faviconLink, faviconIco),
  fallback = faviconDuckDuckGo
) {

  if (!is.character(links)) {
    stop("The argument `links` must be a character vector of URLs")
  }

  if (!validFunctions(functions)) {
    stop("The argument `functions` must be a list of functions or NULL")
  }

  if (!validFallback(fallback)) {
    stop("The argument `fallback` must be a function with one argument or a single character string")
  }

  linksParsed <- xml2::url_parse(links)
  favicons <- character(length = length(links))
  for (i in seq_along(links)) {
    scheme <- linksParsed[i, "scheme"]
    server <- linksParsed[i, "server"]
    path <- linksParsed[i, "path"]
    for (favFunc in functions) {
      favicons[i] <- favFunc(scheme, server, path)
      if (favicons[i] != "") break
    }
    if (favicons[i] == "") {
      if (is.function(fallback)) {
        favicons[i] <- fallback(server)
      } else {
        favicons[i] <- fallback
      }
    }
  }
  return(favicons)
}

#' @export
faviconLink <- function(scheme, server, path) {
  siteURL <- sprintf("%s://%s/%s", scheme, server, path)
  xml <- xml2::read_html(siteURL)
  xpath <- "/html/head/link[@rel = 'icon' or @rel = 'shortcut icon']"
  linkElement <- xml2::xml_find_first(xml, xpath)
  href <- xml2::xml_attr(linkElement, "href")
  if (is.na(href)) return("")

  # The link in href could be absolute, root-relative, or relative
  if (startsWith(href, "http")) { # absolute
    favicon <- href
  } else if (startsWith(href, "/")) { # root-relative
    favicon <- sprintf("%s://%s%s", scheme, server, href)
  } else { # relative
    favicon <- sprintf("%s://%s/%s/%s", scheme, server, path, href)
  }
  return(favicon)
}

#' @export
faviconIco <- function(scheme, server, path) {
  favicon <- sprintf("%s://%s/favicon.ico", scheme, server)
  response <- tryCatch(
    suppressWarnings(
      utils::download.file(favicon, destfile = nullfile(), quiet = TRUE)
    ),
    error = function(e) return(1)
  )
  if (response == 0) {
    return(favicon)
  } else {
    return("")
  }
}

#' Use DuckDuckGo's favicon service
#'
#' The search engine \href{https://duckduckgo.com/}{DuckDuckGo} includes site
#' favicons in its search results, and it makes this service publicly available.
#' If it can't a favicon, it returns a default fallback. faviconPlease uses this
#' as a fallback function if the favicon can't be found directly via the
#' standard methods.
#'
#' @param server
#'
#' @return Character vector
#'
#' @examples
#'   faviconDuckDuckGo("reactome.org")
#'
#' @references
#'   \href{https://help.duckduckgo.com/duckduckgo-help-pages/features/favicons/}{DuckDuckGo favicons},
#'   \href{https://help.duckduckgo.com/duckduckgo-help-pages/privacy/favicons/}{DuckDuckGo favicons privacy}
#'
#' @export
faviconDuckDuckGo <- function(server) {
  iconService <- "https://icons.duckduckgo.com/ip3/%s.ico"
  favicon <- sprintf(iconService, server)
  return(favicon)
}

#' @export
faviconGoogle <- function(server) {
  iconService <- "https://www.google.com/s2/favicons?domain_url=%s"
  favicon <- sprintf(iconService, server)
  return(favicon)
}

validFunctions <- function(functions) {
  if (is.null(functions)) return(TRUE)

  if (!is.list(functions)) return(FALSE)

  eachIsFunction <- vapply(functions, is.function, logical(1))
  if (!all(eachIsFunction)) return(FALSE)

  return(TRUE)
}

validFallback <- function(fallback) {
  if (is.character(fallback) && length(fallback) == 1) {
    return(TRUE)
  }

  if (is.function(fallback) && length(formals(fallback)) == 1) {
    return(TRUE)
  }

  return(FALSE)
}
