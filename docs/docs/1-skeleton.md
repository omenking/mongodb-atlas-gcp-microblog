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

## Rackup our server (Run our web-application)

To start the server run `rackup`

```
rackup
```

This will start the server on a port `9292` by default

Using this Gitpod CLI command lets view it the browser:
```
gp preview $(gp url 4567) --external
```

You should see the web-app running.
Stop the running web-server by using SIGTERM press `Ctrl+C`

Now lets run the server again but by typing following:
```
bundle exec rackup --host 0.0.0.0 -p 4567
```

- bundle exec - is an explict way to run our rackup command in the context of our gemfile
- --host - We want to bind on port 0.0.0.0, this will be important when we are running the app in a container so we can route traffic out of the container
- --port - We are going to run on port 4567 because this is the standard convention for sintra apps but we could make this port whatever like to be honest.

## Defining Our API

Our sintra app will be responsbile for serving up our API as JSON.
Lets first describe our endpoints before we implement them:

- GET /api/activities/home - the activity for entire website (the townsquare)
- GET /api/activities/user/:handle - the activity for a specific user
- POST /api/activities - a user creating an activity
- GET /api/activities/search?term=term - being able to search across all activity

> There will be more api endpoints later we implement Authenication

## Setup Namespace and first JSON API endpoint

Add the following to the `app/Gemfile`:
```
gem 'sinatra-contrib'
```

Run `bundle install`

We want this so we have `namespace` DSL for our sintra app.

Update our `app/app.rb` to look like the following:

```rb
require 'sinatra'
require "sinatra/namespace"
require 'json'

namespace '/api' do
  get '/activities' do
    content_type 'application/json'
    { hello: "World" }.to_json
  end
end
```

Start up your application and navigate to this new route:

```
gp preview $(gp url 4567)/api/activities --external
```

## Reloading in Development

So we don't have to constantly restart our application add the following line near the top of your sintra app

```rb
require "sinatra/reloader" if development?
```

The full file:
```rb
require 'sinatra'
require "sinatra/namespace"
require 'json'
require "sinatra/reloader" if development?

namespace '/api' do
  get '/activities' do
    content_type 'application/json'
    { hello: "World" }.to_json
  end
end
```

Now we can just updated code and check it.

- sinatra/reloader is part of the sinatra-contrib gem which we included
- by default when do not specific an enviroment Sintra will run in Development mode later we'll have to explicty set the enviroment variable

## Implement mock endpoints

We'll create a services directory and file for each action:
```
cd $THEIA_WORKSPACE_ROOT/app
mkdir services
cd services
touch home_activities.rb user_activities.rb search_activities.rb create_activity.rb
cd ..
```

Change your `app/app.rb` to appear as the following:

```rb
require 'sinatra'
require "sinatra/namespace"
require 'json'
require "sinatra/reloader" if development?
require_relative "services/home_activities"
require_relative "services/user_activities"
require_relative "services/search_activities"
require_relative "services/create_activity"

namespace '/api' do
  before do
    content_type 'application/json'
  end

  get '/activities/home' do
    data = HomeActivities.run
    return data.to_json
  end

  get '/activities/@:handle' do
    user_handle  = params['handle']
    data = UserActivities.run user_handle: user_handle
    return data.to_json
  end

  get '/activities/search' do
    search_term = params['term']
    data = SearchActivities.run search_term: search_term
    return data.to_json
  end

  post '/activities' do
    message      = params['message']
    user_handle  = params['handle']
    model = CreateActivity.run message: message, user_handle: user_handle
    if model.errors.any?
      status 422
      return model.errors.to_json
    else
      status 200
      return model.data.to_json
    end # if model.errors.any?
  end
end # namespace
```

update `services/home_activities.rb` with:

```rb
class HomeActivities
  def self.run
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now
    }]
    return results
  end
end
```

update `services/user_activities.rb` with

```rb
class UserActivities
  def self.run user_handle:
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now
    }]
    return results
  end
end
```

update `services/search_activities.rb` with:

```rb
class SearchActivities
  def self.run search_term:
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now
    }]
    return results
  end
end
```

Check the get endpoints to see if they return the expected json data.


> Remember to replace the `User` with the respected file ec. HomeActivities

update the `services/create_activity.rb` with the following:

```rb
require "ostruct"

class CreateActivity
  def self.run message:, user_handle:
    data = {
      handle:  user_handle,
      message: message,
      created_at: Time.now
    }   

    model = OpenStruct.new
    model.errors = []
    model.data = data

    return model
  end
end
```




## Generate Fake User Data

```
cd $THEIA_WORKSPACE_ROOT
mkdir bin
touch bin/seed
```

Within our new seed file add the following:

```
#!/usr/bin/env ruby
require 'faker'

puts 
```

Then run:
```
chmod u+x bin/seed
```

> cd $THEIA_WORKSPACE_ROOT is the fast way for us to get back to workspace project directory. $THEIA_WORKSPACE_ROOT is an Enviroment Variable that points here. See for yourself by running `echo $THEIA_WORKSPACE_ROOT`