class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user)
    else
    @users = User.all
    render :edit
    end

  end


  private

  def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end

def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if user_id != login_user_id
      redirect_to user_path(login_user_id)
    end
  end

end
