require_relative '../models/animal.rb'
require_relative '../models/shop.rb'

post '/animals' do
  #CREATE
  @animal = Animal.new(params)
  @animal.save
  redirect to("/shops/#{params['shop_id']}")
end

get '/animals/:id' do
  #SHOW
  @animal = Animal.find(params[:id])
  @shop = @animal.shop
  erb :"animals/show"
end

get '/animals/:id/edit' do
  #EDIT
  @animal = Animal.find(params[:id])
  @shops = Shop.all
  erb :"animals/edit"
end

post '/animals/:id' do
  #UPDATE
  @animal = Animal.update(params)
  redirect to("/shops/#{params['shop_id']}")
end

delete '/animals/:id' do
  #DELETE
end