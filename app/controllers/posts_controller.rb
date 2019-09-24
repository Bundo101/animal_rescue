class PostsController < ApplicationController


get '/posts' do
    #binding.pry
    if params[:cat_name]
      #@posts = Post.all.select { |post| post.name.downcase.include?(params[:cat_name].downcase) }
      @posts = Post.where('name LIKE ?', "%#{params[:cat_name]}%")
    else  
      @posts = Post.all
    end
    erb :'/posts/index'
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
    if @post
      erb :'posts/show'
    else
      flash[:error] = "Post not found"
      redirect '/'
    end
  end

  delete '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect "/users/#{current_user.id}"
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    if logged_in? && current_user.id == @post.user_id
      erb :'posts/edit'
    else
      flash[:error] = "Please log in to edit existing posts."
      redirect '/login'
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
