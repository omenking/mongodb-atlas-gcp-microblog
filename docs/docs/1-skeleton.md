# Creating a Skeleton Sintra App as a docker containe

I want to keep this application is simple as possible.
Rails has alot of great built-in stuff, but when we are building modern applications and want to best leverage serverless or managed cloud services with a cloud-first approach, alot of the framework gets abstracted away.

I've choosen `Sintra` because I like using Ruby, and for begineers you won't have to worry about all the magic of Ruby.

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

Place the following in your Gemfile:

```rb
source 'https://rubygems.org'

gem 'sinatra'
gem 'webrick'
```

- source - this specifies the remote repo where we'll pull our deps
- sintra - is the webframework we plan to use
- webrick - is the web-server that will server our application

I've choosen webrick because since we are running our web-app inside of a container, you only run a single process for the app per container. Puma which is very popular is suited for running multiple rails instance on a single Virtual Machine. We can use Puma but its just simpler to use webrick


Lets install our deps (you need to be in the app directory)

```
bundle install
```

This will generate a Gemfile which will specific what exact versions of gems you are using.