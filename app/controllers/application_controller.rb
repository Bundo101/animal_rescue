require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'kitty'
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect '/user_homepage'
    else
      erb :index
    end
  end  

  get '/error' do
    erb :error
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
