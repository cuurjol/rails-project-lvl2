# Application Collective Blog

Collective Blog is an application-clone of the famous service [Habr](https://habr.com/ru/all/). Each user can create 
a post and publish it in one of the general categories. Other users rate and comment on added posts.

[![Actions Status](https://github.com/cuurjol/rails-project-lvl2/workflows/hexlet-check/badge.svg)](https://github.com/cuurjol/rails-project-lvl2/actions)
[![CI](https://github.com/cuurjol/rails-project-lvl2/actions/workflows/main.yml/badge.svg)](https://github.com/cuurjol/rails-project-lvl2/actions/workflows/main.yml)

## Installation and running

To run the application, do the following commands in your terminal window:

* Clone the repository from GitHub and navigate to the application folder:
```
git clone https://github.com/cuurjol/rails-project-lvl2.git
cd rails-project-lvl2
```

* Install the necessary application gems specified in the `Gemfile`:
```
bundle install
```

* Create a database, run database migrations and a `seeds.rb` file to create database records:
```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

The application uses the `SQLite` database for development/test environment and the `Postgresql` database for 
production environment.

* Launch the application (local server):
```
bundle exec rails server
```

## Heroku deployment

Study project is ready for deployment on the Heroku. The working version of the project can be viewed at 
[Heroku website](https://cuurjol-hexlet-collective-blog.herokuapp.com/).

## Author

**Kirill Ilyin**, study project from [Hexlet](https://ru.hexlet.io/)
