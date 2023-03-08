require 'sinatra'
require "sinatra/json"

class App < Sinatra::Base

  @@data = Array.new

  get '/prices' do
    rental_price = @@data.map { |row| row[:rental_price].to_f }
    
    json data: {
      avg_rental_price: rental_price.sum / rental_price.count,
      max_rentral_price: rental_price.max,
      min_rental_price: rental_price.min,
    }
  rescue ZeroDivisionError
    json error: { message: 'Empty data' }
  end

  post '/prices' do
    @@data.push(
      JSON.parse(request.body.read, symbolize_names: true)
    )

    json data: @@data
  end
end