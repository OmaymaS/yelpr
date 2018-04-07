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
#' business_search(api_key = key, parameters = list(term ='food',
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

business_search <- function(api_key, parameters){

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
#' business_lookup_id(key, 'gary-danko-san-francisco')
#'
#' @export
business_lookup_id <- function(api_key, business_id){

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
#' business_search_phone(api_key = key, phone_number = '+14159083801')
#'
#' @export

business_search_phone <- function(api_key, phone_number){

  res <- GET("https://api.yelp.com/v3/businesses/search/phone",
             add_headers(Authorization = prepare_header(api_key)),
             query = list(phone = phone_number))

  fromJSON(content(res, type = "text"))
}


#' return up to three review excerpts for a given business ordered by Yelp's default sort order
#'
#' @examples
#' key <- "######"
#' business_search_review(key, 'gary-danko-san-francisco')
#'
#' @export
#'
business_search_review <- function(api_key, business_id){

  endpoint_url <- paste0("https://api.yelp.com/v3/businesses/", business_id, "/reviews")

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)))

  fromJSON(content(res, type = "text"))
}


#' return autocomplete suggestions for search keywords, businesses and categories, based on the input text
#' @param api_key string
#' @param input_text Text to return autocomplete suggestions for
#' @param latitude Required if want to get autocomplete suggestions for businesses. Latitude of the location to look for business autocomplete suggestions.
#' @param longitude Required if want to get autocomplete suggestions for businesses. Longitude of the location to look for business autocomplete suggestions.
#'
#' @examples
#' key <- "######"
#' business_search_autocomplete(key, "star")
#'
business_search_autocomplete <- function(api_key,
                                         input_text,
                                         latitude = NULL,
                                         longitude =  NULL,
                                         ...
                                         ){

  parameters <-  parameters <- c(as.list(environment()), list(...))
  parameters <-  parameters[2:length(parameters)]

  res <- GET("https://api.yelp.com/v3/autocomplete",
             add_headers(Authorization = prepare_header(api_key)),
             query = list(text = input_text))

  fromJSON(content(res, type = "text"))
}


#'  return a list of businesses which support food delivery transactions.
#'
#' @param api_key string
#' @param transaction_type currently "delivery"
#' @param location Required when latitude and longitude aren't provided. Address of the location you want to deliver to
#' @param latitude Required when location isn't provided. Latitude of the location you want to deliver to.
#' @param longitude Required when location isn't provided. Longitude of the location you want to deliver to.
#'
#' @examples
#' key <- "######"
#' business_search_transaction(key,
#'                            transaction_type = "delivery",
#'                            longitude = "-122.399305736113", latitude = "37.787789124691")
#'
#' business_search_transaction(key,
#'                            transaction_type = "delivery",
#'                            location = "94105")
#'
#' @export

business_search_transaction <- function(api_key,
                                        transaction_type = "delivery",
                                        location = NULL,
                                        latitude = NULL,
                                        longitude = NULL
                                        ){


  parameters <-  parameters <- c(as.list(environment()))
  parameters <-  parameters[3:length(parameters)]

  endpoint_url <- paste0("https://api.yelp.com/v3/transactions/", transaction_type, "/search")

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)),
             query = parameters)

  fromJSON(content(res, type = "text"))
}


# business_search_transaction2 <- function(api_key,
#                                         transaction_type = "delivery",
#                                         parameters){
#
#   endpoint_url <- paste0("https://api.yelp.com/v3/transactions/", transaction_type, "/search")
#
#   res <- GET(endpoint_url,
#              add_headers(Authorization = prepare_header(api_key)),
#              query = parameters)
#
#   fromJSON(content(res, type = "text"))
# }



#'  match business data from other sources against businesses on Yelp, based on minimal provided information.
#'
#'  @examples
#' key <- "######"
#' business_match_name2(key, "lookup",
#'                     name = "Good",
#'                     city = "San Francisco",
#'                     state = "CA",
#'                     country = "US",
#'                     postal_code = "12345")
#'
#'  @export

business_match_name <- function(api_key,
                                type = "lookup",
                                name, city, state, country, ...){

  parameters <- c(as.list(environment()), list(...))
  parameters <-  parameters[3:length(parameters)]

  endpoint_url <- paste0("https://api.yelp.com/v3/businesses/matches/", type)

  res <- GET(endpoint_url,
             add_headers(Authorization = prepare_header(api_key)),
             query = parameters)

  fromJSON(content(res, type = "text"))
}


# business_match_name2 <- function(api_key,
#                                 type = "lookup",
#                                 parameters){
#
#   endpoint_url <- paste0("https://api.yelp.com/v3/businesses/matches/", type)
#
#   res <- GET(endpoint_url,
#              add_headers(Authorization = prepare_header(api_key)),
#              query = parameters)
#
#   fromJSON(content(res, type = "text"))
# }



