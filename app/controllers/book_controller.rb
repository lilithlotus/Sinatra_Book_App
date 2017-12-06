class BookController < ApplicationController

  get '/books/new' do
    @genres = Genre.all
    erb :'books/create_book'
  end

  post '/books/new' do
    @book = Book.create(params)
    redirect to "/books/#{@book.slug}"
  end

  get '/books/:slug' do
    @book = Book.find_by_slug(params[:slug])
    erb :'books/show_book'
  end

  get '/books' do
    erb :'/books/show'
  end
end
