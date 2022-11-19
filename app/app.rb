require 'sinatra'
require "sinatra/namespace"
require 'json'
require "sinatra/reloader" if development?
require_relative "services/home_activities"
require_relative "services/user_activities"
require_relative "services/search_activities"
require_relative "services/create_activity"
require 'rack/contrib'
use Rack::PostBodyContentTypeParser

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
    if model.errors.any?
      status 422
      return model.errors.to_json
    else
      status 200
      return model.data.to_json
    end # if model.errors.any?
  end

  post '/activities' do
    message      = params[:message]
    user_handle  = params[:handle]

    puts "params: #{params.inspect}"
    puts "message: #{message}"
    puts "user_handle: #{user_handle}"
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