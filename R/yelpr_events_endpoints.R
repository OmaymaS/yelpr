#' return the detailed information of a Yelp event
#'
#' @details
#' This endpoint requires you be in yelp developer beta
#'
#' @param api_key string
#' @param event_id event id
#'
#' @return
#' * attending_count: Number of Yelp users attending this event
#' * category: The category alias of this event
#' * cost: Cost of attending this event
#' * cost_max: Maximum cost of this event
#' * description: Description excerpt of this event
#' * event_site_url: Yelp page of this event
#' * id: Event id
#' * image_url: Yelp image URL of this event
#' * interested_count: Number of Yelp users interested in attending this event
#' * is_canceled: Whether this event is canceled
#' * is_free: Whether this event is free
#' * is_official: Whether this event is created by a Yelp community manager
#' * latitude: Latitude of this event
#' * longitude: Longitude of this event
#' * name: Name of this event
#' * tickets_url: URL to buy tickets for this event
#' * time_end: Time this event ends. Returns date and time in the following format - "YYYY-MM-DD HH-mm"
#' * time_start: Time this event starts. Returns date and time in the following format - "YYYY-MM-DD HH-mm"
#' * location: 	The location of this event, including address, city, state, zipcode and country
#' * business_id: Yelp Business ID of this event. No ID is returned if a business is not associated with an event
#' @md
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

#' return events based on the provided search criteria
#'
#' @param api_key string
#' @param ... optional parameters [More](https://www.yelp.com/developers/documentation/v3/event_search)
#'
#' @return List with the following elements:
#' * total: Total number of events returned based on search criteria
#' * events: List of events found matching search criteria
#' @md
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


#' return the featured event for a given location
#'
#' @description
#' Featured events are chosen by Yelp's community managers
#'
#' @param api_key string
#' @param transaction_type currently "delivery"
#' @param location Required, if latitude and longitude not provided. Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used while searching for events.
#' @param latitude Required, if location not provided. Latitude of the location to search from.
#' @param longitude Required, if location not provided. Longitude of the location to search from.
#'
#' @return
#' * attending_count: Number of Yelp users attending this event
#' * category: The category alias of this event
#' * cost: Cost of attending this event
#' * cost_max: Maximum cost of this event
#' * description: Description excerpt of this event
#' * event_site_url: Yelp page of this event
#' * id: Event id
#' * image_url: Yelp image URL of this event
#' * interested_count: Number of Yelp users interested in attending this event
#' * is_canceled: Whether this event is canceled
#' * is_free: Whether this event is free
#' * is_official: Whether this event is created by a Yelp community manager
#' * latitude: Latitude of this event
#' * longitude: Longitude of this event
#' * name: Name of this event
#' * tickets_url: URL to buy tickets for this event
#' * time_end: Time this event ends. Returns date and time in the following format - "YYYY-MM-DD HH-mm"
#' * time_start: Time this event starts. Returns date and time in the following format - "YYYY-MM-DD HH-mm"
#' * location: 	The location of this event, including address, city, state, zipcode and country
#' * business_id: Yelp Business ID of this event. No ID is returned if a business is not associated with an event
#' @md
#'
#' @examples
#' key <- "######"
#' event_search_featured(api_key = key, location = 'New York')
#'
#' @export

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
