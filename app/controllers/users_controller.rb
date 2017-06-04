class UsersController < ApplicationController
  def new

  end

  def create
    temp = params[:user][:password_digest]
    temp = Digest::SHA1.hexdigest(temp)
    params[:user][:password_digest] = temp
    @user = User.new(user_params)

    @user.save
    redirect_to signin_path
  end

  def index
    @users = User.all
  end
  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end

