#' return the detailed information of a Yelp event
#'
#' @details
#' This endpoint requires you be in yelp developer beta
#'
#' @param api_key string
#' @param event_id event id
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
#' event_search(key, limit = 10)
#'
#' @export
event_search <- function(api_key, ...){

  parameters <- list(...)

  res <- GET("https://api.yelp.com/v3/events",
            add_headers(Authorization = prepare_header(api_key)),
            query = parameters)

  fromJSON(content(res, type = "text"))
}


#' return the featured event for a given location. Featured events are chosen by Yelp's community managers.
#'
#' @param api_key string
#' @param transaction_type currently "delivery"
#' @param location Required, if latitude and longitude not provided. Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used while searching for events.
#' @param latitude Required, if location not provided. Latitude of the location to search from.
#' @param longitude Required, if location not provided. Longitude of the location to search from.
#'
#' @examples
#' key <- "######"
#' event_search_featured(api_key = key, location = 'New York')
#'
#' @export
#'

event_search_featured <- function(api_key,
                                  location = NULL,
                                  latitude = NULL,
                                  longitude = NULL){

  parameters <-  parameters <- c(as.list(environment()))
  parameters <-  parameters[2:length(parameters)]

  res <- GET("https://api.yelp.com/v3/events/featured",
             add_headers(Authorization = prepare_header(api_key)),
             query = parameters)

  fromJSON(content(res, type = "text"))
}

# event_search_featured2 <- function(api_key, parameters){
#
#   res <- GET("https://api.yelp.com/v3/events/featured",
#              add_headers(Authorization = prepare_header(api_key)),
#              query = parameters)
#
#   fromJSON(content(res, type = "text"))
# }
