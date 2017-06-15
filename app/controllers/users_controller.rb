class UsersController < ApplicationController
  def new
    if current_user != nil
      redirect_to homes_path
    end
    @user = User.new
  end

  def create

    temp = params[:user][:password_digest]
    if temp != "" && temp.length >= 4
      temp = Digest::SHA1.hexdigest(temp)
      params[:user][:password_digest] = temp
    end
    @user = User.new(user_params)
    @users = User.all
    if @user.save
      redirect_to signin_path
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
    @host = User.find(params[:id])
    if @user.id != @host.id
      redirect_to homes_path
    end
  end

  def show
    @user = current_user
    @host = User.find(params[:id])
    if @user == nil || @user.id != @host.id
      redirect_to homes_path
    end

  end

  def update
    @user = current_user
    temp = params[:user][:password_digest]
    if temp != "" && temp.length >= 4
      temp = Digest::SHA1.hexdigest(temp)
      params[:user][:password_digest] = temp
    end
    if @user.update(user_params)
      redirect_to homes_path
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end
