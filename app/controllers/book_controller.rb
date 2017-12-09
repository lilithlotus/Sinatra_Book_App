class BookController < ApplicationController

  get '/books' do
    if !logged_in?
      #if user is not logged in redirects to login otherwise takes user to page to show all books ever created
      redirect to '/login'
    end
    @books = Book.all
    erb :'/books/show'
  end

  get '/books/new' do
    @genres = Genre.all
    if logged_in?
      #if logged in takes user to form to create a new book, otherwise redirects to login page
      erb :'books/create_book'
    else
      redirect to '/login'
    end
  end


  post '/books' do
    @book = Book.find_or_create_by(params)
    #finds the book by all criteria if it exists or creates it if it does not
    @book.users << current_user
    # adds the user if to the array of users that have added this book
    if @book.save
      redirect to "/books/#{@book.slug}"
    else
      redirect to 'books/new'
    end
  end

  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])
    if logged_in?
      #if logged in takes user to book edit form, if not takes user to login
      erb :'books/edit'
    else
      redirect to '/login'
    end
  end

  post '/books/:slug/edit' do
    #updates book information
    @book = Book.find_by_slug(params[:slug])
    @book.name = params[:name]
    @book.author = params[:author]
    @book.genre_id = params[:genre]
    @book.save
    redirect to "/books/#{@book.slug}"
  end

  get '/books/:slug' do
    @user = current_user
    @book = Book.find_by_slug(params[:slug])
    if logged_in?#if logged in shows the page for that one book based on slug
      erb :'books/show_book'
    else
      redirect to '/login'
    end
  end

  get '/books/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @books = []
    Book.all.each do |b|
      if b.user_ids.include?(current_user.id)
        @books << b
      end
    end
    #shows all the books in a users collection
    erb :'users/show'
  end

  post '/books/:slug/delete' do
    @user = current_user
    #deletes book if user has that book
    @book = Book.find_by_slug(params[:slug])
    if @book.user_ids.include?(current_user.id)
      @book.destroy
    end
    redirect to "books/users/${@user.slug}"
  end




end
