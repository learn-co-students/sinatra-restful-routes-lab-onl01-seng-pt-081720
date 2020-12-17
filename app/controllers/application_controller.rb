class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #REMINDER: write RECIPES instead of recipies

  #displays all the recipes in the database
  get '/recipes' do
    @recipes = Recipe.all
    #REMINDER: this one is RECIPES not recipe
    erb :index
  end

  #renders form to create new recipe
  get '/recipes/new' do
    erb :new
  end

  #creates and saves the new recipe to the database
  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])

    redirect to "/recipes/#{@recipe.id}"
  end

  #show action - displays one article based on ID in the URL
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])

    erb :show
  end

  #loads edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])

    erb :edit
  end

  #updates recipe based on input from edit form
  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])

    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])

    @recipe.delete
    redirect '/recipes'
  end

end
