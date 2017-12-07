class UserController < ApplicationController

  get '/login' do
    if logged_in?
      redirect to '/books'
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/books"
    else
        redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/books'
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/books'
    else
      redirect to '/signup'
    end
  end

  get 'logout' do
    session.clear
    redirect to '/login'
  end
end
