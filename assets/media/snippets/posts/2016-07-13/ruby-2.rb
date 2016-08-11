# config.ru
require 'bundler/setup'
require 'sinatra/config_file'
require 'omniauth-facebook'
require './app.rb'

config_file './secrets.yml'

use Rack::Session::Cookie, secret: settings.cookies["secret"]

use OmniAuth::Builder do
  # For multiple strategies configs
end

run Sinatra::Application
