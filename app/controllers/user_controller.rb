class UserController < ApplicationController

  get '/login' do
    if logged_in?#if logged in takes to page of books user has, if not takes to login
      @user = current_user
      redirect to "/users/#{@user.slug}"
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    # if the user exists and the password is correct sets the session id and takes
    #user to list of their books, otherwise sends back to login
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/users/#{@user.slug}"
    else
        redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      #if logged in takes user to list of their books, otherwise sends them back to login
      @user = current_user
      redirect to "/users/#{@user.slug}"
    end
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params)
    #if the user enters valid information and is saved a session id is saved and user is taken to their book list
    #otherwise user is sent back to signup page to try again
    if @user.save
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    #clears the session hash, loggin the person out
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    #finds all books that user has and takes them to a page to view them
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
