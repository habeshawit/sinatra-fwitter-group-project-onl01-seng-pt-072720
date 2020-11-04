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
        end
    end

    post '/tweets' do
        user = Helpers.current_user(session)
        
        tweet = Tweet.create(:content => params["content"], :user_id => user.id)
    
        redirect to '/tweets'
      end
    
    
end
