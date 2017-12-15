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
    @user = current_user
    @genres = Genre.all
    if logged_in?
      #if logged in takes user to form to create a new book, otherwise redirects to login page
      erb :'books/create_book'
    else
      redirect to '/login'
    end
  end


  post '/books' do
    @book = Book.create(params)
    #creates book
    if @book.save
      redirect to "/books/#{@book.slug}"
    else
      redirect to 'books/new'
    end
  end

  get '/books/:slug/edit' do
    if logged_in?
      if @book = current_user.books.find_by_slug(params[:slug])
      #if logged in takes user to book edit form, if not takes user to login
        erb :'books/edit'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  #form submits
  #the request to the server
  #rack intercepts the request
  #then passes the request to the controllers
  #sthen the controllers process the HTTP verb and url and try to match it

  patch '/books/:slug/edit' do
    #updates book information
    if logged_in?
      if @book = current_user.books.find_by_slug(params[:slug])
        @book.update(params[:book])
        #@book.name = params[:name]
        #@book.author = params[:author]
        #@book.genre_id = params[:genre]
        #@book.save
        redirect to "/books/#{@book.slug}"
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
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
      if b.user == @user
        @books << b
      end
    end
    #shows all the books in a users collection
    erb :'users/show'
  end

  delete '/books/:slug/delete' do
    @user = current_user
    #deletes book if user has that book
    @book = Book.find_by_slug(params[:slug])
      @book.destroy
    redirect to "books/users/${@user.slug}"
  end




end
