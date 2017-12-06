class BookController < ApplicationController

  get '/books/new' do
    erb :'books/create_book'
  end

  post '/books/new' do
    
  end
end
