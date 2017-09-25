require 'sinatra'
require 'httparty'
require 'json'
require 'pry'
require_relative './citygram/animal_care'
require_relative './citygram/homeless'
require_relative './citygram/sewer'
require_relative './citygram/code_enforcement'
require_relative './citygram/urban_forestry

set :bind, '0.0.0.0'

get '/' do
  'Hello World!'
end

get '/animal_care' do
  response, headers['Next-Page'] = Citygram::AnimalCare.retrieve_records(params[:offset].to_i)
  response
end

get '/homeless' do
  response, headers['Next-Page'] = Citygram::Homeless.retrieve_records(params[:offset].to_i)
  response
end

get '/sewer' do
  response, headers['Next-Page'] = Citygram::Sewer.retrieve_records(params[:offset].to_i)
  response
end

get '/code_enforcement' do
    response, headers['Next-Page'] =  Citygram::CodeEnforcement.retrieve_records(params[:offset].to_i)
  response
end

get '/urban_forestry' do
response, headers['Next-Page'] =  Citygram::UrbanForestry.retrieve_records(params[:offset].to_i)
  response
end
    