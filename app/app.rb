$stdout.sync = true

require 'sinatra'
require "sinatra/namespace"
require 'json'
require "sinatra/reloader"
require_relative "services/home_activities"
require_relative "services/user_activities"
require_relative "services/search_activities"
require_relative "services/create_activity"
require 'rack/contrib'
require "sinatra/cors"
require_relative "config/initializers/mongo"

# refresh
use Rack::JSONBodyParser

backend  = ENV['BACKEND_URL']
frontend = ENV['FRONTEND_URL']

puts ENV['MONGO_ATLAS_URL']
puts ENV['MONGO_DATABASE']

backend = "https://4567-omenking-mongodbatlasgc-97v3x8ruxof.ws-us78.gitpod.io"
frontend = "https://3000-omenking-mongodbatlasgc-97v3x8ruxof.ws-us78.gitpod.io"


### BAYKO
set :logger, Logger.new(STDOUT) 

puts "CORS SET----!!"
puts backend
puts frontend

set :allow_origin , [backend,frontend].join(' ')
set :allow_methods, "OPTIONS,GET,HEAD,POST,PUT,PATCH,DELETE"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

    
configure :development do
  enable :reloader
  pwd = File.dirname(__FILE__) 
  also_reload "./services/*"
  after_reload do
    puts 'reloaded'
  end
end

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

    model = UserActivities.run user_handle: user_handle
    if model.errors.any?
      status 422
      return model.errors.to_json
    else
      status 200
      return model.data.to_json
    end # if model.errors.any?
  end

  get '/activities/search' do
    search_term = params['term']

    model = SearchActivities.run search_term: search_term
    
    ### BAYKO
    logger.info model.data.to_json
    
    if model.errors.any?
      status 422
      return model.errors.to_json
    else
      status 200
      return model.data.to_json
    end # if model.errors.any?
  end

  post '/activities' do
    puts "set params: #{params.inspect}"
    message      = params[:message]
    user_handle  = 'andrewbrown' # hardcoded for now
    model = CreateActivity.run message: message, user_handle: user_handle
    
    ### BAYKO
    logger.info model.data.to_json
    
    if model.errors.any?
      puts 'test errors'
      puts model.errors.to_json
      status 422
      return model.errors.to_json
    else
      status 200
      return model.data.to_json
    end # if model.errors.any?
  end
end # namespace