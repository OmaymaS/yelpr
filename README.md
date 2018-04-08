# yelpr




```r
library(DT)
```


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

To use the package, it is required to have an API key as clarified in the previous section. In the following examples, we will read the key once from a saved file. You could create your own file or assign the key directly in the code.


```r
# load yelpr package
library(yelpr)
```


```r
## assign app key
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
DT::datatable(business_ny$businesses, class = "compact")
```

<!--html_preserve--><div id="htmlwidget-843ffc97adcad4c23169" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-843ffc97adcad4c23169">{"x":{"filter":"none","data":[["1","2","3","4","5"],["k8GFfCXO2FIIJIo0ICYSRA","X8ZS-dgiMIJvhwf9SaDnjw","croh2zWlbPyCQTNS11klcg","0CjK3esfpFcxIopebzjFxA","lynQoI3w_pzYfHGeuUU-Qg"],["bao-bao-cafe-new-york-3","wah-fung-no-1-new-york","sichuan-manor-new-york-3","joes-shanghai-new-york-2","shu-jiao-fu-zhou-cuisine-restaurant-new-york"],["Bao Bao Cafe","Wah Fung No 1","Sichuan Manor","Joe's Shanghai","Shu Jiao Fu Zhou Cuisine Restaurant"],["https://s3-media2.fl.yelpcdn.com/bphoto/pjJHmOiblI-oVf6NBjgL9g/o.jpg","https://s3-media2.fl.yelpcdn.com/bphoto/QrbtEYSiE_AQkqu59Qmp4Q/o.jpg","https://s3-media2.fl.yelpcdn.com/bphoto/QcWywXc47siclZkYCsxJnQ/o.jpg","https://s3-media3.fl.yelpcdn.com/bphoto/ekUo5egd4dlE7zJyb4-Leg/o.jpg","https://s3-media2.fl.yelpcdn.com/bphoto/TALCyEl-e45rDrKk3vCWaQ/o.jpg"],[false,false,false,false,false],["https://www.yelp.com/biz/bao-bao-cafe-new-york-3?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&amp;utm_campaign=yelp_api_v3&amp;utm_medium=api_v3_business_search&amp;utm_source=ms3wnheA1zMACsW_cG2W_Q","https://www.yelp.com/biz/wah-fung-no-1-new-york?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&amp;utm_campaign=yelp_api_v3&amp;utm_medium=api_v3_business_search&amp;utm_source=ms3wnheA1zMACsW_cG2W_Q","https://www.yelp.com/biz/sichuan-manor-new-york-3?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&amp;utm_campaign=yelp_api_v3&amp;utm_medium=api_v3_business_search&amp;utm_source=ms3wnheA1zMACsW_cG2W_Q","https://www.yelp.com/biz/joes-shanghai-new-york-2?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&amp;utm_campaign=yelp_api_v3&amp;utm_medium=api_v3_business_search&amp;utm_source=ms3wnheA1zMACsW_cG2W_Q","https://www.yelp.com/biz/shu-jiao-fu-zhou-cuisine-restaurant-new-york?adjust_creative=ms3wnheA1zMACsW_cG2W_Q&amp;utm_campaign=yelp_api_v3&amp;utm_medium=api_v3_business_search&amp;utm_source=ms3wnheA1zMACsW_cG2W_Q"],[26,930,35,4991,472],[{"alias":["noodles","chinese"],"title":["Noodles","Chinese"]},{"alias":["chinese"],"title":["Chinese"]},{"alias":["szechuan","dimsum"],"title":["Szechuan","Dim Sum"]},{"alias":["shanghainese","seafood","venues"],"title":["Shanghainese","Seafood","Venues & Event Spaces"]},{"alias":["chinese"],"title":["Chinese"]}],[4.5,4.5,4.5,4,4.5],{"latitude":[40.70854,40.71735,40.7581711239604,40.7146691442891,40.7184290357839],"longitude":[-74.01367,-73.99457,-73.9883149042726,-73.9977602206654,-73.9916928979573]},[["delivery","pickup"],"restaurant_reservation",["restaurant_reservation","delivery","pickup"],[],["pickup","restaurant_reservation"]],["$","$","$$$","$$","$"],{"address1":["106 Greenwich St","79 Chrystie St","258 W 44th St","9 Pell St","118 Eldridge St"],"address2":[null,"",null,"",null],"address3":["","","","",null],"city":["New York","New York","New York","New York","New York"],"zip_code":["10006","10002","10036","10013","10002"],"country":["US","US","US","US","US"],"state":["NY","NY","NY","NY","NY"],"display_address":[["106 Greenwich St","New York, NY 10006"],["79 Chrystie St","New York, NY 10002"],["258 W 44th St","New York, NY 10036"],["9 Pell St","New York, NY 10013"],["118 Eldridge St","New York, NY 10002"]]},["+19172617122","+12129255175","+16467670854","+12122338888","+12126252532"],["(917) 261-7122","(212) 925-5175","(646) 767-0854","(212) 233-8888","(212) 625-2532"],[1663.25541418963,1323.28518070673,5884.48647388588,1066.50854983491,1460.31286033864]],"container":"<table class=\"compact\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>id<\/th>\n      <th>alias<\/th>\n      <th>name<\/th>\n      <th>image_url<\/th>\n      <th>is_closed<\/th>\n      <th>url<\/th>\n      <th>review_count<\/th>\n      <th>categories<\/th>\n      <th>rating<\/th>\n      <th>coordinates<\/th>\n      <th>transactions<\/th>\n      <th>price<\/th>\n      <th>location<\/th>\n      <th>phone<\/th>\n      <th>display_phone<\/th>\n      <th>distance<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[7,9,16]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


### Events Endpoint

The available functions are:

- event_lookup_id()
- event_search()
- event_search_featured()

For example, `event_search_featured` returns the featured event, chosen by Yelp's community managers, for a given location. The location OR (longitude+latitude) are required.

Here we'll get the details of featured event in the given location using the longitude and latitude.


```r
# search featured event in the given location coordinates
event <- event_search_featured(api_key = key,
                      longitude = "-74.01385", latitude = "40.70387")
```

And the event name would be:

```r
event$name
```

```
[1] "52 Things To Do in 2018"
```

