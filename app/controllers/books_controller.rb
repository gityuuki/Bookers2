class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      @books = Book.all
       flash[:notice]="successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def update
   @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
     book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end
 
 def is_matching_login_user
      book = Book.find(params[:id])
      user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
 end
end

