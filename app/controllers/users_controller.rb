class UsersController < ApplicationController

    get '/signup' do
        erb :'users/signup'
      end
    
    post '/signup' do  
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if user.save
          session[:user_id] = user.id
          redirect '/user_homepage'
        else
          @error = user.errors.full_messages.to_sentence
          flash[:error] = @error
          redirect '/signup'
        end 
    end
    
    get '/login' do
        erb :'users/login'
    end
    
    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/user_homepage'
        else
            @error = user.errors.full_messages.to_sentence
            flash[:error] = @error
            redirect '/login'
        end
    end
      
    get '/user_homepage' do
        if logged_in?
            @posts = Post.all
            @posts = @posts.reject { |post| post.user_id != current_user.id }
            erb :'users/user_homepage'
        else
            redirect '/error'
        end
    end
    
    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/*' do
        "Ooooppss that address doesn't seem to be valid"
        
        #insert message plus link to homepage 
    end

end
