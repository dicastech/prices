require 'sinatra'
require "sinatra/json"

require_relative 'lib/local_data'

class App < Sinatra::Base
  get '/prices' do    
    json LocalData.call
  rescue ZeroDivisionError
    json error: { message: 'Empty data' }
  end

  post '/prices' do
    data = LocalData.push(
      JSON.parse(request.body.read, symbolize_names: true)
    )

    json data: data
  end
end