require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/posts" do
    @posts = Post.all
    erb :post_list
  end

  # get '/recipes' do
  #   @recipes = Recipe.all
  #   erb :index
  # end

end
