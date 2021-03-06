class UsersController < ApplicationController
  before_action :login_check, only: [:show, :index, :edit, :update]

  def create
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
  end
  def index
    @users = User.all.order(create_at: :desc)
    @book = Book.new
  end
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
         flash[:notice] = "You have updated user successfully."
         redirect_to user_path(@user.id)
    else
        render "edit"
    end
  end
  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def login_check
    unless user_signed_in?
      redirect_to user_session_path
    end
  end
end
