#' search businesse on yelp
#'
#' @param api_key string
#' @param parameters list corresponding to API paremeters  \url{https://www.yelp.com/developers/documentation/v3/business_search}
#'
#' @details
#' * location(string): Required if either latitude or longitude is not provided. Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used when searching for businesses
#' * latitude(decimal): Required if location is not provided. Latitude of the location you want to search nearby
#' * longitude(decimal): Required if location is not provided. Longitude of the location you want to search nearby.
#' * optional parameters ..
#'
#' @examples
#' # search businesses with keyword 'food' in New York
#' key <- "######"
#' search_business(api_key = key, parameters = list(term ='food',
#'                                                  location = 'New York'))
#'
#' @return List with the following elements:
#' * total: Total number of business Yelp finds based on the search criteria. Sometimes, the value may exceed 1000. In such case, you still can only get up to 1000 businesses. total may be limited to 40 for non-default sorts such as "distance" and "review_count"
#' * businesses:  List of business Yelp finds based on the search criteria
#' * region: Suggested area in a map to display results in
#' @md
#'
#' @import jsonlite
#' @import httr
#' @export

search_business <- function(api_key, parameters){

  res <- GET("https://api.yelp.com/v3/businesses/search",
      add_headers(Authorization = prepare_header(api_key)),
      query = parameters)

  fromJSON(content(res, type = "text"))
}


#' Search businesses on yelp by id
#'
#' @param api_key string
#' @param id string
#'
#' @examples
#' key <- "######"
#' lookup_business_id(key, 'gary-danko-san-francisco')
#'
#' @export
lookup_business_id <- function(api_key, business_id){

  endpoint_url <- paste0("https://api.yelp.com/v3/businesses/", business_id)

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)))

  fromJSON(content(res, type = "text"))
}

#' Return a list of businesses on yelp based on the provided phone number
#'
#' @param api_key string
#' @param phone_number Phone number of the business you want to search for. It must start with + and include the country code, like +14159083801
#'
#' @return List with the following elements:
#'  * total: Total number of business Yelp finds based on the search criteria. Sometimes, the value may exceed 1000. In such case, you still can only get up to 1000 businesses. total may be limited to 40 for non-default sorts such as "distance" and "review_count"
#' * businesses:  List of business Yelp finds based on the search criteria
#' @md
#'
#' @examples
#' key <- "######"
#' search_phone(api_key = key, phone_number = '+14159083801')
#'
#' @export

search_phone <- function(api_key, phone_number){

  res <- GET("https://api.yelp.com/v3/businesses/search/phone",
             add_headers(Authorization = prepare_header(api_key)),
             query = list(phone = phone_number))

  fromJSON(content(res, type = "text"))
}


#' return up to three review excerpts for a given business ordered by Yelp's default sort order
#'
#' @examples
#' key <- "######"
#'search_business_review(key, 'gary-danko-san-francisco')
#'
#' @export
#'
search_business_review <- function(api_key, business_id){

  endpoint_url <- paste0("https://api.yelp.com/v3/businesses/", business_id, "/reviews")

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)))

  fromJSON(content(res, type = "text"))
}


#' return autocomplete suggestions for search keywords, businesses and categories, based on the input text
#'
#' @examples
#' key <- "######"
#' search_autocomplete(key, "star")
#'
search_autocomplete <- function(api_key, input_text){

  res <- GET("https://api.yelp.com/v3/autocomplete",
             add_headers(Authorization = prepare_header(api_key)),
             query = list(text = input_text))

  fromJSON(content(res, type = "text"))
}


#'
#'
# search_transaction <- function(api_key,
#                                location =  NULL,
#                                latitude = NULL,
#                                longitude = NULL){
#
#
# }

#' https://api.yelp.com/v3/businesses/matches/best
#' #requires you be in our developer beta.
# match_business_best <- function(){
#
# }
