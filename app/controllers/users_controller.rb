class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, {only: [:edit,:update,:destroy]}

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    @current_user = current_user

  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user)
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render:edit
    end
  end




  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
