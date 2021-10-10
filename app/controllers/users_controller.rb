class UsersController < ApplicationController

before_action :check_user, only: [:edit, :update]

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:success] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def create

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def check_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end


end
