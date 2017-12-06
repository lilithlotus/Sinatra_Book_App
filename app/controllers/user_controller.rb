class UserController < ApplicationController

  get '/login' do
    erb :'users/login'
  end

  post '/login' do

  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    
  end
end
