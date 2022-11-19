# Creating a Skeleton Sintra App as a docker containe

I want to keep this application is simple as possible.
Rails has alot of great built-in stuff, but when we are building modern applications and want to best leverage serverless or managed cloud services with a cloud-first approach, alot of the framework gets abstracted away.

I've choosen `Sinatra` because I like using Ruby, and for begineers you won't have to worry about all the magic of Ruby.

We are going to try to keep the code as much as possible in a single file.

## Create a Sintra web-app directory and file structure

Create an new directory called app with the following files:

```
mkdir app
cd app
touch Gemfile app.rb config.ru
```

- app.rb - will contain on programming code
- config.ru - sintra is rack compatiable application and we need a rack file to startup the server
- Gemfile - this is where our programming libraries are declared

We will end up with a directory structure that looks like this:

```
- app
  - Gemfile
  - app.rb
  - config.ru
```

## Create Gemfile and install deps

Place the following in your `app/Gemfile`:

```rb
source 'https://rubygems.org'

gem 'sinatra'
gem 'webrick'
gem 'rack
```

- source - this specifies the remote repo where we'll pull our deps
- sintra - is the webframework we plan to use
- webrick - is the web-server that will server our application
- rack - adaptable interface for developing web applications in Ruby

I've choosen webrick because since we are running our web-app inside of a container, you only run a single process for the app per container. Puma which is very popular is suited for running multiple rails instance on a single Virtual Machine. We can use Puma but its just simpler to use webrick


Lets install our deps (you need to be in the app directory)

```
bundle install
```

This will generate a Gemfile which will specific what exact versions of gems you are using.

## Define our Sintra Hello World Code

In your `app/app.rb` file:

```
require 'sinatra'

get '/' do
  'Hello World!'
end
```

Sintra has as DSL that makes it easy to write apps in single file.
Here we've defined a root path eg: localhost:4567/ which the home page of our application

In your `config.ru` add the following:

```
require './app.rb'
run Sinatra::Application
```

The config.ru is the configuration file for rack

What does rack do?

> wrapping HTTP requests and responses in the simplest way possible, it unifies and distills the bridge between web servers, web frameworks, and web application into a single method call

There are many different kinds of ruby web-framework and Rack is a layer that sits infront of web-apps to normalize their behaviour. Rack is able to add middleware so it can process, tranform and do things to incoming HTTP requests before it reaches our sintra code.

We are just using it because it standard, and we probably won't be doing any complex configuration