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

### Business Endpoint 

```
key <- "######"

# search businesses with keyword 'food' in 'New York'
search_business(api_key = key, parameters = list(term ='food',
                                                 location = 'New York'))
```
