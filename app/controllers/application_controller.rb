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
      redirect "/users/#{current_user.id}"
    else
      erb :index
    end
  end  

  helpers do
		def logged_in?
			!!current_user
		end

		def current_user
			User.find_by_id(session[:user_id])
		end
	end
  
end
