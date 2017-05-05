# Build Your Own API - Mixtape

You are going to build an API using Rails! When finished, you'll be able to run the server and, instead of going to your browser, you will go to Postman and see some sweet, sweet JSON containing a list of songs! Let's go make a mixtape!

## Learning Goals
  - Know how to create a new rails app for an API
  - How to make an API return JSON, instead of rendering html
  - Using Postman to see the results of all your hard work.

## Overview
Here's a short list of what we'll be doing. Below we will go into more detail with each step.

- Create a new rails API project with the following command:
  - `rails new mixtape --api`
- Create a new model for songs that has the following attributes:
  - title
  - artist
  - year
- Create seed data for songs
- Create a GET route to show all songs
- Create an index method in the controller method to query all songs
- Render JSON from the controller method

## What's new?

We are using Rails only for the purpose of rendering JSON to clients of this application, therefore we do not need to handle anything with views. By providing the argument `--rails` when we created our rails app, it will not generate any of the files associated with views.

 It also has our controller inheriting from ActionController::API base instead of ActionController::Base. This gives us additional, API specific functionality that we will use.


## Let's Get Started
- The first step of creating our rails app is going to be a _slightly_ different, but is very important! **MAKE SURE YOUR CREATE YOUR NEW RAILS APP WITH '--API'** It is going to save you a lot of time getting started. So, run the following command to generate a new API rails app:
  - `rails new . --api`

- **Create a new model for songs**
`rails generate model song title:string artist:string year:integer`
-  **Create and Migrate your database**
    - `rails db:create`
    - `rails db:migrate`
- **Create seed data**
    - add `gem 'faker'` to your Gemfile
    - run `bundle install`
    - Add the following code to your `seeds.rb` file
  ```Ruby
  100.times do
    Song.create(title: Faker::Hipster.sentence(3), artist: Faker::Name.name, year: rand(1950..2017) )
  end
   ```
- **In terminal, run `rails db:seed`**
- **Create a Route for Songs index**
  ```Ruby
  get '/songs', to: 'songs#index', as: 'songs'
  ```
- **Create a controller method**
  ```Ruby
    def index
      songs = Song.all
    end
  ```
- **Have the controller method render JSON**
  ```Ruby
  def index
    songs = Song.all
    render :json => songs
  end
  ```
- **Have the JSON render only specific fields, and return a status code**
  ```Ruby
  def index
    songs = Song.all
    render :json => songs.as_json(only: [:id, :title, :artist, :year]), status: :ok
   end
   ```
- **Test in Postman!**
  - Go to Postman, and make a get request with this url: `localhost:3000/songs`
  - You should see something like:
```JavaScript
    [
      {
        "id": 1,
        "title": "Actually pork belly photo booth ethical.",
        "artist": "Lessie Schmeler DVM",
        "year": 1988
      },
      {
        "id": 2,
        "title": "Seitan pinterest chillwave chicharrones gluten-free pug single-origin coffee.",
        "artist": "Theo Herzog PhD",
        "year": 1958
      },
      {
        "id": 3,
        "title": "Sustainable narwhal organic diy chambray schlitz.",
        "artist": "Justen Jakubowski",
        "year": 1994
      }
    ]
```
- **Have Fun!**
    - Instead of returning all songs, return a random selection of 12


## Additional Resources
- [Scotch.io API with Rails](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one) (Goes into a lot of depth, especially with testing w/ RSPEC.)
