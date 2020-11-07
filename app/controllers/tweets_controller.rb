class TweetsController < ApplicationController

    get '/' do
        erb :index
    end

    get '/tweets' do
        @tweets = Tweet.all
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        else
            # @tweets= Tweet.all
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
            if tweet.save
                redirect "/tweets"
            end   
        else
            redirect "/tweets/new"
        end

    end
    
    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
          @tweet = Tweet.find_by(id: params[:id])
          erb :"tweets/show"
        else
          redirect to '/login'
        end
    end
    
    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.is_logged_in?(session) && @tweet.user == Helpers.current_user(session)
            erb :"tweets/edit"
        else
            redirect '/login'
        end
    end


    patch '/tweets/:id' do #edit action
        @tweet = Tweet.find_by_id(params[:id])
        
        if @tweet && @tweet.user == Helpers.current_user(session) && params[:content] != ""
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
      end

      delete '/tweets/:id' do #delete action
        
        @tweet = Helpers.current_user(session).tweets.find_by(:id => params[:id])
    
        if @tweet
          @tweet.delete
          redirect "/tweets"
        else
          redirect "/tweets"
        end
      
      end
    
  
end
