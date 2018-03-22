#' prepare header by appending "Bearer" to the api_key
#'
#' @param api_key string

prepare_header <- function(api_key){
  paste("Bearer", api_key)
}

