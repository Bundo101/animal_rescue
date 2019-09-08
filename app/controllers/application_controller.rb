require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "kitty"
  end

  get "/" do
    erb :index
  end

  get "/posts" do
    @posts = Post.all
    erb :post_list
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do  
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
		if user.save
      redirect "/login"
		else
			redirect "/error"
		end 
  end

  get "/signup_failure" do
    erb :signup_failure
  end
  
  get "/login" do
		erb :login
	end

  post "/login" do
		user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
			redirect "/user_homepage"
		else
			erb :error
		end
	end
  
  get "/user_homepage" do
    if logged_in?
      erb :user_homepage
    else
      erb :error
    end
  end

  get "/error" do
    erb :error
  end

  get '/logout' do
    session.clear
    redirect "/"
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
