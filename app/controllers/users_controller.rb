class UsersController < ApplicationController
    get '/signup' do 
   
        if Helpers.is_logged_in?(session) 
          redirect '/tweets'
        else 
          erb :'/users/signup' 
        end 
      end 
    
      post '/signup' do
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        session[:user_id] = user.id
    
        if user.save && user.username != "" && user.email !="" && user.password !=""
                redirect "/tweets"
            else
                redirect "/signup"
            end
    
      end
    
      get '/login' do 
        if Helpers.is_logged_in?(session)
          redirect to '/tweets'
        end
        
        erb :"/users/login"
      end
    
      post '/login' do
        user = User.find_by(:username => params["username"])
    
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end

      get '/logout' do
        if Helpers.is_logged_in?(session)
            redirect to '/login'
        else
            redirect to 'views/index'
        end

        erb :"users/logout"
      end

    get '/users/:slug' do
        @user = User.find_slug(params[:slug])
      erb :"users/show"  
        
    end
    
    

end
