require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    #enables sessions
  end

  get "/" do
    @genres = Genre.all
    erb :welcome
  end

  helpers do
      def logged_in?
      #helper moethod to determine if user if logged in, not, not session is user_id
        !!session[:user_id]
      end

      def current_user
        #returns the User_id for current user by looking at session hash
        User.find(session[:user_id])
      end
    end

end
