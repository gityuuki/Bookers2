class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def index
    @user = current_user
  end
   
  def show

  end

end


