# README

## Production
    https://clonebnb-airbnb-look-a-like.herokuapp.com/
## About
    This projects is a look-a-like of AirBnb written in ruby using a rails framework. We used postrgresql as our databases and rspec for our test suite.

    Just like AirBnb you can search for cities you want to stay in and choose from a variety of places that are available, book a reservation, contact the owners of the places available, and leave comments about the experience.

    This project is designed to display understanding of how to make an app that mimics those that are currently in use all the while displaying understanding of API creation and the implementation and management of API endpoints.

    During the project we organized ourselves and features using waffle and used Heroku for production. Now Heroku's asset pipeline is implemented to integrate continuous deployment and TravisCI is integrated into the branch merging process to automate testing. This project is also used for continuous integration and testing with Jenkins and will be hosted on AWS which will additionally implement Docker.  

## Setup
    - `bundle install`
    - `rake db:create db:migrate db:seed`
    - To run the project locally: `rails s`, then navigate to `localhost:3000`
    - To run the tests: `rspec`

## API Endpoints:
    (all query params case insensitive)

#### Get a property's data data
    `/api/v1/listings/find?`
          Parameters
          * title
          * street address
          * city
#### Get all property data meeting a criteria
    `/api/v1/listings/find_all?`
          Parameters
          * city
          * state
          * zipcode
          * all
          * list_type
          * max_occupancy
          * cost_per_night

#### Cities with a count of how many properties are in that city
    `/api/v1/listings/count/?city=denver`

#### Cities most frequently visited
    `/api/v1/reservations/complete/ranked_by_cities`

#### Properties ranked by most visited
    `/api/v1/listings/most_visited?limit=num`

#### Properties ranked by highest rated, give a limit
    `/api/v1/listings/highest_rated?limit=num`

#### Properties ranked by most visited for a city, give limit
    `/api/v1/listings/most_visited?city=denver&limit=num`

#### Properties ranked by highest rated for a city, give limit
    `/api/v1/listings/highest_rated?city=denver&limit=num`
