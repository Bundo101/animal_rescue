class PostsController < ApplicationController


get '/posts' do
    @posts = Post.all
    erb :post_list
  end

  get '/posts/new' do
    erb :'posts/new'
  end

  post '/posts' do
    @post = Post.new(params)
    @post.user = current_user
    @post.save
    redirect "/posts/#{@post.id}"
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :'posts/show'
  end

  delete '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect '/user_homepage'
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :'posts/edit'
  end

  patch '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.colour = params[:colour]
    @post.gender = params[:gender]
    @post.age = params[:age]
    @post.save
    redirect "/posts/#{@post.id}"
  end


end
