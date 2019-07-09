class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Please complete all fields."
      redirect to '/signup'
    else
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save
      session[:user_id] = user.id
      redirect to '/bills'
    end


  end

  get '/login' do
    if logged_in?
      redirect to '/bills'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/bills'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end
