# app.rb
require 'sinatra'
require 'sinatra/reloader'

# configure sinatra
set :run, false
set :raise_errors, true

get '/login/:provider' do
  # For OAuth login requests
end

get '/auth/:provider/callback' do
  # For OAuth login callbacks
end
