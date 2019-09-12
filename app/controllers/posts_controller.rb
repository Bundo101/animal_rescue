class PostsController < ApplicationController


get '/posts' do
    @posts = Post.all
    erb :'/posts/post_list'
  end

  get '/posts/new' do
    if logged_in?
      erb :'posts/new'
    else
      flash[:error] = "Please log in to advertise a cat for adoption."
      redirect '/login'
    end
  end

  post '/posts' do
    @post = Post.new(params)
    @post.user = current_user
    @post.save
    redirect "/posts/#{@post.id}"
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(@post.user_id)
    erb :'posts/show'
  end

  delete '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect '/user_homepage'
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    if logged_in? && current_user.id == @post.user_id
      erb :'posts/edit'
    else
    end
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
