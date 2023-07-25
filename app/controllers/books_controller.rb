class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def index
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    @user = current_user
    @books = Book.all
    redirect_to book_path(@book.id)
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end