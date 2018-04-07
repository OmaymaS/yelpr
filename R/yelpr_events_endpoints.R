#' return the detailed information of a Yelp event
#' This endpoint requires you be in yelp developer beta
#'
#' @examples
#' key <- "######"
#' event_lookup_id(key, "oakland-saucy-oakland-restaurant-pop-up")
#'
#' @export

event_lookup_id <- function(api_key, event_id){

  endpoint_url <- paste0("https://api.yelp.com/v3/events/", event_id)

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)))

  fromJSON(content(res, type = "text"))
}

#' return events based on the provided search criteria.
#'
#' @examples
#' key <- "######"
#' ## retrieve 10 events
#' event_search(key, list(limit = 10))
#'
#' @export
event_search <- function(api_key, parameters = list()){

  res <- GET("https://api.yelp.com/v3/events",
            add_headers(Authorization = prepare_header(api_key)),
            query = parameters)

  fromJSON(content(res, type = "text"))
}


#' return the featured event for a given location. Featured events are chosen by Yelp's community managers.
#'
#' @export

event_search_featured <- function(api_key, parameters){

  res <- GET("https://api.yelp.com/v3/events/featured",
             add_headers(Authorization = prepare_header(api_key)),
             query = parameters)

  fromJSON(content(res, type = "text"))
}
