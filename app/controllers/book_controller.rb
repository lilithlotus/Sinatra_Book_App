class BookController < ApplicationController

  get '/books' do
    if !logged_in?
      redirect to '/login'
    end
    @books = Book.all
    erb :'/books/show'
  end

  get '/books/new' do
    @genres = Genre.all
    if logged_in?
      erb :'books/create_book'
    else
      redirect to '/login'
    end
  end

  post '/books' do
    @book = Book.find_or_create_by(params)
    @book.user = current_user
    if @book.save
      redirect to "/books/#{@book.slug}"
    else
      redirect to 'books/new'
    end
  end

  get '/books/:slug' do
    @book = Book.find_by_slug(params[:slug])
    if logged_in?
      erb :'books/show_book'
    else
      redirect to '/login'
  end



  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])
    if logged_in?
      erb :'books/edit'
    else
      redirect to '/login'
  end

  post '/books/:slug/edit' do

  end
end
