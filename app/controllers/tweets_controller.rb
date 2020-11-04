class TweetsController < ApplicationController

    get '/' do
        erb :index
    end

    get '/tweets' do
        # @tweets = Tweet.all
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        else
            @tweets= Tweet.all
            @user = Helpers.current_user(session)
            erb :"tweets/index"
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :"tweets/new"
        else
            redirect to "users/login"
        end

    end

    post '/tweets' do
        user = Helpers.current_user(session)
        if !params["content"].empty?
            tweet = Tweet.create(:content => params["content"], :user_id => user.id)
            if tweet.save && tweet.content != "" 
                redirect "/tweets"
            end   
        else
            redirect "/tweets/new"
        end

    end

    

    
    
    
end
