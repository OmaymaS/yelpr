# README



# yelpr

An R library for the [Yelp Fusion API](https://www.yelp.com/developers/documentation/v3/get_started)

## Installation

## API Authentication

From [yelp authentication guide](https://www.yelp.com/developers/documentation/v3/authentication) :

"In order to set up your access to Yelp Fusion API, you need to create an app with Yelp. This app represents the application you'll build using our API and includes the credentials you'll need to gain access. Here are the steps for creating an app:

- Go to [Create App](https://www.yelp.com/developers/v3/manage_app)
- In the create new app form, enter information about your app, then agree to Yelp API Terms of Use and Display Requirements. Then click the Submit button.
- You will now have an API Key."


## Usage

To use the package, it is recquired to have an API key as clarified in the previous section. In the following examples, we will read the key once from a saved file. You could create your own file or assign the key directly in the code.


```r
library(yelpr)
```


```r
key <- readLines("yelp_app_key.txt")
```

### Business Endpoint 

The available functions are:

- `business_search()`
- `business_lookup_id()`
- `business_search_phone()`
- `business_search_review()`
- `business_search_autocomplete()`
- `business_search_transaction()`
- `business_match_name()`


For example `business_search()` returns up to 1000 businesses based on the provided search criteria. The location OR (longitude+latitude) are required, plus Additional [optional parameters](https://www.yelp.com/developers/documentation/v3/business_search).

Here we will retrieve the first 5 results in new york with the term 'chinese'


```r
# search businesses with keyword 'chinese' in 'New York'
business_ny <- business_search(api_key = key,
                location = 'New York',
                term = "chinese",
                limit = 5)
```

The function returns a list, so we could see the details of the businesses as follows:


```r
business_ny$businesses
```

```
##                       id                                        alias
## 1 k8GFfCXO2FIIJIo0ICYSRA                      bao-bao-cafe-new-york-3
## 2 X8ZS-dgiMIJvhwf9SaDnjw                       wah-fung-no-1-new-york
## 3 croh2zWlbPyCQTNS11klcg                     sichuan-manor-new-york-3
## 4 0CjK3esfpFcxIopebzjFxA                     joes-shanghai-new-york-2
## 5 lynQoI3w_pzYfHGeuUU-Qg shu-jiao-fu-zhou-cuisine-restaurant-new-york
##                                  name
## 1                        Bao Bao Cafe
## 2                       Wah Fung No 1
## 3                       Sichuan Manor
## 4                      Joe's Shanghai
## 5 Shu Jiao Fu Zhou Cuisine Restaurant
##                                                              image_url
## 1 https://s3-media2.fl.yelpcdn.com/bphoto/pjJHmOiblI-oVf6NBjgL9g/o.jpg
## 2 https://s3-media2.fl.yelpcdn.com/bphoto/QrbtEYSiE_AQkqu59Qmp4Q/o.jpg
## 3 https://s3-media2.fl.yelpcdn.com/bphoto/QcWywXc47siclZkYCsxJnQ/o.jpg
## 4 https://s3-media3.fl.yelpcdn.com/bphoto/ekUo5egd4dlE7zJyb4-Leg/o.jpg
## 5 https://s3-media2.fl.yelpcdn.com/bphoto/TALCyEl-e45rDrKk3vCWaQ/o.jpg
##   is_closed
## 1     FALSE
## 2     FALSE
## 3     FALSE
## 4     FALSE
## 5     FALSE
##                                                                                                                                                                                                         url
## 1                      https://www.yelp.com/biz/bao-bao-cafe-new-york-3?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=ms3wnheA1zMACsW_cG2W_Q
## 2                       https://www.yelp.com/biz/wah-fung-no-1-new-york?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=ms3wnheA1zMACsW_cG2W_Q
## 3                     https://www.yelp.com/biz/sichuan-manor-new-york-3?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=ms3wnheA1zMACsW_cG2W_Q
## 4                     https://www.yelp.com/biz/joes-shanghai-new-york-2?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=ms3wnheA1zMACsW_cG2W_Q
## 5 https://www.yelp.com/biz/shu-jiao-fu-zhou-cuisine-restaurant-new-york?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=ms3wnheA1zMACsW_cG2W_Q
##   review_count
## 1           26
## 2          930
## 3           35
## 4         4990
## 5          472
##                                                                    categories
## 1                                          noodles, chinese, Noodles, Chinese
## 2                                                            chinese, Chinese
## 3                                         szechuan, dimsum, Szechuan, Dim Sum
## 4 shanghainese, seafood, venues, Shanghainese, Seafood, Venues & Event Spaces
## 5                                                            chinese, Chinese
##   rating coordinates.latitude coordinates.longitude
## 1    4.5             40.70854             -74.01367
## 2    4.5             40.71735             -73.99457
## 3    4.5             40.75817             -73.98831
## 4    4.0             40.71467             -73.99776
## 5    4.5             40.71843             -73.99169
##                               transactions price location.address1
## 1                         delivery, pickup     $  106 Greenwich St
## 2                   restaurant_reservation     $    79 Chrystie St
## 3 restaurant_reservation, delivery, pickup   $$$     258 W 44th St
## 4                                             $$         9 Pell St
## 5           pickup, restaurant_reservation     $   118 Eldridge St
##   location.address2 location.address3 location.city location.zip_code
## 1              <NA>                        New York             10006
## 2                                          New York             10002
## 3              <NA>                        New York             10036
## 4                                          New York             10013
## 5              <NA>              <NA>      New York             10002
##   location.country location.state             location.display_address
## 1               US             NY 106 Greenwich St, New York, NY 10006
## 2               US             NY   79 Chrystie St, New York, NY 10002
## 3               US             NY    258 W 44th St, New York, NY 10036
## 4               US             NY        9 Pell St, New York, NY 10013
## 5               US             NY  118 Eldridge St, New York, NY 10002
##          phone  display_phone distance
## 1 +19172617122 (917) 261-7122 1663.255
## 2 +12129255175 (212) 925-5175 1323.285
## 3 +16467670854 (646) 767-0854 5884.486
## 4 +12122338888 (212) 233-8888 1066.509
## 5 +12126252532 (212) 625-2532 1460.313
```


### Events Endpoint

The available functions are:

- event_lookup_id()
- event_search()
- event_search_featured()

For example, `event_search_featured` returns the featured event, chosen by Yelp's community managers, for a given location. The location OR (longitude+latitude) are required.

Here we'll get the featured event in the given location using the longitude and latitude parameters.


```r
# search featured event in New York
event_search_featured(api_key = key,
                      longitude = "-74.01385", latitude = "40.70387")
```

```
## $attending_count
## [1] 1477
## 
## $category
## [1] "other"
## 
## $cost
## [1] 500
## 
## $cost_max
## [1] 0
## 
## $description
## [1] "What the heck is this? Back by popular demand, this is an essential list of at least one Yelp-approved activity to accomplish every week throughout 2018...."
## 
## $event_site_url
## [1] "https://www.yelp.com/events/new-york-52-things-to-do-in-2018?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&utm_campaign=yelp_api_v3&utm_medium=api_v3_event_featured&utm_source=ms3wnheA1zMACsW_cG2W_Q"
## 
## $id
## [1] "new-york-52-things-to-do-in-2018"
## 
## $image_url
## [1] "https://s3-media2.fl.yelpcdn.com/ephoto/aVqlc21JYisuWUgdltzYoA/o.jpg"
## 
## $interested_count
## [1] 976
## 
## $is_canceled
## [1] FALSE
## 
## $is_free
## [1] FALSE
## 
## $is_official
## [1] FALSE
## 
## $latitude
## [1] 40.70387
## 
## $longitude
## [1] -74.01385
## 
## $name
## [1] "52 Things To Do in 2018"
## 
## $tickets_url
## [1] ""
## 
## $time_end
## [1] "2018-04-28 06:30"
## 
## $time_start
## [1] "2018-03-28 07:00"
## 
## $location
## $location$address1
## [1] ""
## 
## $location$address2
## [1] ""
## 
## $location$address3
## [1] ""
## 
## $location$city
## [1] "New York"
## 
## $location$zip_code
## [1] "10004"
## 
## $location$country
## [1] "US"
## 
## $location$state
## [1] "NY"
## 
## $location$display_address
## [1] "New York, NY 10004"
## 
## $location$cross_streets
## [1] ""
## 
## 
## $business_id
## [1] "new-york-city-new-york-14"
```


