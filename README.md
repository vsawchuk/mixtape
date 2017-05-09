# Build Your Own API Mixtape

You are going to build an API using Rails! When finished, you'll be able to run the server and, instead of going to your browser, you will go to Postman and see some sweet, sweet JSON containing a list of songs!

Let's go make a mixtape!

## Learning Goals
  - Know how to create a new rails project specifically for an API
  - How to make an API return JSON, instead of rendering html
  - Use Postman to see the results of all your hard work

## Overview
Here's a short list of what we'll be doing. Below we will go into more detail with each step.

- Create a new rails API project with the following command:
  - `rails new mixtape --api`
- Create a new model for songs that has the following attributes:
  - title
  - artist
  - year
- Create seed data
- Create a GET route to show all songs
- Create an index method in the controller method to query all songs
- Render JSON from the index controller method

## What's new?

We are using Rails only for the purpose of providing JSON to clients of this application, therefore we do not need to handle anything with html views. By providing the argument `--api` when we create our rails app, it will not generate any of the files associated with views.

It also has our controller inheriting from ActionController::API base instead of ActionController::Base. This gives us only the API specific functionality of Rails.


## Let's Get Started
- The first step of creating our rails app is going to be a _slightly_ different, but is very important! **MAKE SURE YOU CREATE YOUR NEW RAILS APP WITH '--api'** It is going to save you a lot of time with getting started. Before Rails 5 there was a much more manual process that we do not have to do anymore thanks to that simple command! So, run the following command to generate a new API rails app:
  - `rails new . --api`
- **Create a new model for songs**
  - `rails generate model song title:string artist:string year:integer`
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
- **Have the controller method render JSON** Up until now everything should have been familiar. But now we need to add a line to our controller method to tell it to render JSON. Also take note that we used a local variable instead of an instance one. Why do you think that is?
  ```Ruby
  def index
    songs = Song.all
    render :json => songs
  end
  ```
- **Have the JSON render only specific fields, and return a status code** If there is data we do not want to be given in our JSON, we can specify what we want to pass along. In this case, we do not want to give created_at or updated_at. We can also specify a status code! By default rails will pass the status OK, but you should always specify the status code. This will be especially important when we want to allow users to send POST requests that might not have the right format we are looking for.
  ```Ruby
  def index
    songs = Song.all
    render :json => songs.as_json(only: [:id, :title, :artist, :year]), status: :ok
   end
   ```
- **Test in Postman!**
  - Go to Postman, and make a get request with this url: `localhost:3000/songs`
  - You should see something like (but with a lot more songs!):
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
    - Instead of returning _all_ songs, return a random selection of 12!


## Additional Resources
Most resourses and tutorials will go into more depth and may have different setups of their projects from ours. They may include serializing data, adding versioning to their API's or testing with RSPEC. While it is good to have exposure to all those things, you do not need to use them with our API projects (We will still test with Minitest though!).
- [Rails API Documentation](http://edgeguides.rubyonrails.org/api_app.html)
- [Scotch.io API with Rails](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one) (Goes into a lot of depth, especially with testing w/ RSPEC.)
- [Building a Simple Rails API Blog Post ](http://www.thegreatcodeadventure.com/building-a-super-simple-rails-api-json-api-edition-2/)
