class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, {only: [:edit,:update,:destroy]}

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
    @books = Book.all
      render:index
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all



  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
    @user_id = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
    flash[:notice] = "You have updated book successfully.."
    redirect_to  book_path(@book.id)
   else
    @books = Book.all
    flash[:notice]= ' errors prohibited this obj from being saved:'
    render "edit"
   end
  end
  private


  def book_params
    params.require(:book).permit(:title, :body)
  end
end

