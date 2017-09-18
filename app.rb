require 'sinatra'
require 'httparty'
require 'json'
require 'pry'
require_relative './citygram/animal_care'

set :bind, '0.0.0.0'

get '/' do
  'Hello World!'
end

get '/animal_care' do
  response, headers['Next-Page'] = Citygram::AnimalCare.retrieve_records(params[:offset].to_i)
  response
end
