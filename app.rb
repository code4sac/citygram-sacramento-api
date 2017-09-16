require 'sinatra'
require 'httparty'
require 'json'
require_relative './citygram/animal_care'

set :bind, '0.0.0.0'

get '/' do
  'Hello World!'
end

get '/animal_care' do
  Citygram::AnimalCare.retrieve_records
end
