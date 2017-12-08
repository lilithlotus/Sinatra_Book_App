class UserController < ApplicationController

  get '/login' do
    if logged_in?
      redirect to '/books/new'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/books/new"
    else
        redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/books/new'
    end
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/books/new'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
