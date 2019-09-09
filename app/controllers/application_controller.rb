require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'kitty'
  end

  get '/' do
    if logged_in?
      redirect "/user_homepage"
    else
      erb :index
    end
  end

  get '/posts' do
    @posts = Post.all
    erb :post_list
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.new(params)
    @post.user = current_user
    @post.save
    redirect "/posts/#{@post.id}"
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  delete '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect "/user_homepage"
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
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

  get '/signup' do
    erb :signup
  end

  post '/signup' do  
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/user_homepage'
		else
			redirect '/error'
		end 
  end

  get '/signup_failure' do
    erb :signup_failure
  end
  
  get '/login' do
		erb :login
	end

  post '/login' do
		user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
			redirect '/user_homepage'
		else
			erb :error
		end
	end
  
  get '/user_homepage' do
    if logged_in?
      @posts = Post.all
      @posts = @posts.reject { |post| post.user_id != current_user.id }
      erb :user_homepage
    else
      erb :error
    end
  end

  get '/error' do
    erb :error
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
  
end
