class UserController < ApplicationController

  get '/login' do
    if logged_in?
      @user = current_user
      redirect to "/users/#{@user.slug}"
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/users/#{@user.slug}"
    else
        redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      @user = current_user
      redirect to "/users/#{@user.slug}"
    end
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
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
    @books = []
    Book.all.each do |b|
      if b.user_ids.include?(current_user.id)
        @books << b
      end
    end
    erb :'users/show'
  end
end
