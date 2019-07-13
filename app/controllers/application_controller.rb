require './config/environment'
require "rack-flash"


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash, :sweep => true

  end

  get "/" do
    erb :index
  end

  # helper methods
  helpers do
    # returns true or false based on the presence of a session[:user_id]
    def logged_in?
      !!session[:user_id]
    end

    #returns the instance of the logged in user based on the session[:id]
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end



end
