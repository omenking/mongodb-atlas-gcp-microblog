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
gem 'rack'
gem 'rackup'
```

- source - this specifies the remote repo where we'll pull our deps
- sintra - is the webframework we plan to use
- webrick - is the web-server that will server our application
- rack - adaptable interface for developing web applications in Ruby
- rackup - this is how we run rack servers easily

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

We are just using it because it standard, and we probably won't be doing any complex configuration of rack

Rack is part of sintra so we probably didn't need to include in our Gemfile, but just adding it explicty.

## Rackup our server

To start the server run `rackup`

```
rackup
```

This will start the server on a port `9292` by default

Using this Gitpod CLI command lets view it the browser:
```
gp preview $(gp url 3000) --external
```

You should see the web-app running.
Stop the running web-server by using SIGTERM press `Ctrl+C`

Now lets run the server again but by typing following:
```
bundle exec rackup --host 0.0.0.0 -p 4567
```

- bundle exec - is an explic way to run our rackup command in the context of our gemfile
- --host - We want to bind on port 0.0.0.0, this will be important when we are running the app in a container so we can route traffic out of the container
- --port - We are going to run on port 4567 because this is the standard convention for sintra apps but we could make this port whatever like to be honest.

