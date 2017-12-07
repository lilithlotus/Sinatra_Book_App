class BookController < ApplicationController

  get '/books/new' do
    @genres = Genre.all
    erb :'books/create_book'
  end

  post '/books/new' do
    @book = Book.find_or_create_by(params)

    redirect to "/books/#{@book.slug}"
  end

  get '/books/:slug' do
    @book = Book.find_by_slug(params[:slug])
    erb :'books/show_book'
  end

  get '/books' do
    @books = Book.all
    erb :'/books/show'
  end

  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])

    erb :'books/edit'
  end

  post '/books/:slug/edit' do
    
  end
end
