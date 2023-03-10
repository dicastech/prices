require 'sinatra'
require "sinatra/json"

class App < Sinatra::Base

  @@data = Array.new

  get '/prices' do
    rental_price = @@data.map { |row| row[:rental_price].to_f }
    water_price = @@data.map { |row| row[:water_price].to_f }
    energy_price = @@data.map { |row| row[:energy_price].to_f }
    internet_price = @@data.map { |row| row[:internet_price].to_f }
    marketplace_price = @@data.map { |row| row[:marketplace_price].to_f}
    transport_price = @@data.map { |row| row[:transport_price].to_f }
    leisure_price = @@data.map { |row| row[:leisure_price].to_f }

    response = {
      avg_rental_price: rental_price.sum / rental_price.count,
      max_rentral_price: rental_price.max,
      min_rental_price: rental_price.min,
      
      avg_water_price: water_price.sum / water_price.count,
      max_water_price: water_price.max,
      min_water_price: water_price.min,

      avg_energy_price: energy_price.sum / energy_price.count,
      max_energy_price: energy_price.max,
      min_energy_price: energy_price.min,

      avg_internt_price: internt_price.sum / internt_price.count,
      max_internt_price: internt_price.max,
      min_internt_price: internt_price.min,

      avg_marketplace_price: marketplace_price.sum / marketplace_price.count,
      max_marketplace_price: marketplace_price.max,
      min_marketplace_price: marketplace_price.min,

      avg_transport_price: transport_price.sum / transport_price.count,
      max_transport_price: transport_price.max,
      min_transport_price: transport_price.min,

      avg_leisure_price: leisure_price.sum / leisure_price.count,
      max_leisure_price: leisure_price.max,
      min_leisure_price: leisure_price.min,
      
      data: @@data,
    }

    json response

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