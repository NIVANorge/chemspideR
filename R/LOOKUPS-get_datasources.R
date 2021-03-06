#' @title Get external ChemSpider data sources
#' @description Returns all external ChemSpider data sources.
#' @details "Many other endpoints let you restrict which sources are used to lookup the requested query. Restricting the sources makes queries faster."\cr
#' \cr
#' Returns all available external ChemSpider data sources.\cr
#' \cr
#' This function is most useful for narrowing down \code{dataSources} in other chemspiderapi functions, for example \code{get_recordId_externalreferences()}.
#' @param apikey A 32-character string with a valid key for ChemSpider's API services.
#' @param coerce \code{logical}: should the \code{list} be coerced to a \code{data.frame}? Defaults to \code{FALSE}.
#' @param simplify \code{logical}: should the results be simplified to a \code{vector}? Defaults to \code{FALSE}.
#' @return Either a \code{list}, \code{data.frame}, or \code{vector} of characters.
#' @seealso \url{https://developer.rsc.org/compounds-v1/apis/get/lookups/datasources}
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' ## Get external data sources of ChemSpider
#' apikey <- "A valid 32-character Chemspider API key"
#' get_datasources(apikey = apikey)
#' }
#' @importFrom curl curl_fetch_memory handle_setheaders handle_setopt new_handle
#' @importFrom jsonlite fromJSON 
#' @export
get_datasources <- function(apikey, coerce = FALSE, simplify = FALSE) {
  
  .check_apikey(apikey)
  .check_coerce(coerce)
  .check_simplify(simplify)
  
  header <- list("Content-Type" = "", "apikey" = apikey)
  
  url <- Sys.getenv("GET_DATASOURCES_URL", 
                    "https://api.rsc.org/compounds/v1/lookups/datasources")
  
  handle <- curl::new_handle()
  curl::handle_setopt(handle, customrequest = "GET")
  curl::handle_setheaders(handle, .list = header)
  
  raw_result <- curl::curl_fetch_memory(url = url, handle = handle)

  .check_status_code(raw_result$status_code)

  result <- rawToChar(raw_result$content)
  result <- jsonlite::fromJSON(result)
  
  if (coerce) {
    result <- as.data.frame(result, stringsAsFactors = FALSE)
  }
  
  if (simplify) {
    result <- unlist(result, use.names = FALSE)
  }
  
  result
}
