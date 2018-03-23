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
