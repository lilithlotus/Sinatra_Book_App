class BookController < ApplicationController

  get '/books/new' do
    @genres = Genre.all
    erb :'books/create_book'
  end

  post '/books/new' do
    @book = Book.create(params)
  end
end
