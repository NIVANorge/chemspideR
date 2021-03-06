#' @title Get a gzipped SDF file for a ChemSpider query
#' @description This function is used to download a single .sdf file from ChemSpider after \code{get_queryId_status()} returns \code{"Complete"}.
#' @details Call this function after \code{get_queryId_status()} returns \code{"Complete"}.
#' @param queryId A valid 36-character ChemSpider \code{queryId}.
#' @param status A character string indicating the query status as returned by \code{get_queryId_status()}.
#' @param apikey A 32-character string with a valid key for ChemSpider's API services.
#' @param decode \code{logical}: should the base64-encoded gzipped file be decoded? Defaults to \code{TRUE}.
#' @param simplify \code{logical}: should the results be simplified to a vector? Defaults to \code{FALSE}.
#' @return Returns a (base64-encoded) character vector
#' @seealso \url{https://developer.rsc.org/compounds-v1/apis/get/filter/{queryId}/results/sdf}
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples 
#' \dontrun{
#' ## Get a gzipped .sdf file
#' queryId <- "a valid 36-character ChemSpider apikey"
#' apikey <- "a valid 32-character ChemSpider apikey"
#' get_queryId_results_sdf(queryId = queryId, apikey = apikey)
#' }
#' @importFrom curl curl_fetch_memory handle_setheaders handle_setopt new_handle
#' @importFrom jsonlite base64_dec fromJSON
#' @export
get_queryId_results_sdf <- function(queryId, 
                                    status, 
                                    apikey, 
                                    decode = TRUE,
                                    simplify = FALSE) {
  
  .check_queryId(queryId)
  
  .check_status(status)
  
  .check_apikey(apikey)
  
  .check_simplify(simplify)
  
  header <- list("Content-Type" = "", "apikey" = apikey)
  
  base_url <- Sys.getenv("GET_QUERYID_URL", 
                         "https://api.rsc.org/compounds/v1/filter/")
  
  url <- paste0(base_url, queryId, "/results/sdf")
  
  handle <- curl::new_handle()
  
  curl::handle_setopt(handle, customrequest = "GET")
  
  curl::handle_setheaders(handle, .list = header)
  
  raw_result <- curl::curl_fetch_memory(url = url, handle = handle)
  
  .check_status_code(raw_result$status_code)
  
  result <- rawToChar(raw_result$content)
  result <- jsonlite::fromJSON(result)
  
  if (decode) {
    
    result_decoded <- jsonlite::base64_dec(result$results)
    
    con <- rawConnection(result_decoded)
    
    result$results <- readLines(gzcon(con))
    
    close(con)
    
  }
  
  if (simplify) {
    result <- unlist(result, use.names = FALSE)
  }
  
  result
}
