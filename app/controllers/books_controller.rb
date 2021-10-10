class BooksController < ApplicationController
before_action :check_user, only: [:edit, :update]


  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.where(user_id: current_user.id)
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id)
    else
       render :edit
    end
    flash[:success] = "You have updated book successfully."
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
    flash[:success] = "You have created book successfully."
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
