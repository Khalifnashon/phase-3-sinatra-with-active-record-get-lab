class ApplicationController < Sinatra::Base

  # add routes
  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all.order(:title) 
    # Sorting the bakeries by title

    # return a JSON response with an array of all the bakery data
    bakeries.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/bakeries/:id' do
    # look up the bakery in the database using its ID
    bakery = Bakery.find(params[:id])

    # class Bakery < ActiveRecord::Base
    #   has_many :baked_goods
    # end

    # send a JSON-formatted response of the bakery data
    # include associated baked_goods in the JSON response
    bakery.to_json(include: :baked_goods)

  end    

  get '/baked_goods/by_price' do
    # get all the bakeries from the database
    by_price = BakedGood.all.order(price: :desc)
    # Sorting the bakeries by price in descending order

    # return a JSON response with an array of all the bakery data
    by_price.to_json
  end

  get '/baked_goods/most_expensive' do
    # get the single most expensive baked good from the database
    baked_good = BakedGood.all.order(price: :desc).first

    # return a JSON response with the baked good data
    baked_good.to_json
  end

end
