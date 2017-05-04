#Build Your Own API - Mixtape

You will build an API that, when called with the appropriate url, will return a list of songs as JSON.

## Learning Goals
  - Understand what is different between a rails web project and rails api project
  - How to make an API return JSON, instead of rendering html

## Baseline
- Create a new rails API project with the following command:
  - `rails new mixtape --api`
- Create a new migration for songs that has the following attributes:
  - title
  - artist
  - year
- Create seed data for songs



## What's new?

We are using Rails only for the purpose of rendering JSON to clients of this application, therefore we do not need to handle anything with views. By providing the argument `--rails` when we created our rails app, it did not generate any of the view files. It also has our controller inheriting from an API base instead of ____. This gives us additional, API specific functionality that we will use.


## Let's Get Started
