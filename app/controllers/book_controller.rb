class BookController < ApplicationController

  get '/books/new' do
    erb :'books/create_book'
  end
end
