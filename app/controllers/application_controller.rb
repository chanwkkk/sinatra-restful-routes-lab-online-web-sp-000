require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @all=Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe=Recipe.create(name: params[:name],ingredients: params[:ingredients],cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @id=params[:id]
    @recipe=Recipe.find_by_id(@id)
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe=Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe=Recipe.find_by_id(params[:id])
    @recipe.name=params[:name]
    @recipe.cook_time=params[:cook_time]
    @recipe.ingredients=params[:ingredients]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe=Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end



end
