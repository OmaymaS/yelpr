
#' return the detailed information of a Yelp event
#'
#' @export

event_lookup_id <- function(api_key, event_id){

  endpoint_url <- paste0("https://api.yelp.com/v3/events/", event_id)

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)))

  fromJSON(content(res, type = "text"))

}
