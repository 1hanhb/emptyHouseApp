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
    @user = current_user
    @users = User.all
    if @user == nil || !@user.admin
      redirect_to homes_path
    end
  end

  def show
    @user = current_user
    @host = User.find(params[:id])
    if @user != nil &&  ( @user.id == @host.id || @user.admin)
    else
      redirect_to homes_path
    end
  end

  def edit
    @user = current_user
    @host = User.find(params[:id])
    if @user.admin
    elsif @user == nil || @user.id != @host.id
      redirect_to homes_path
    end
  end

  def update
    @host = User.find(params[:id])
    name = @host.name
    temp = params[:user][:password_digest]
    if temp != "" && temp.length >= 4
      temp = Digest::SHA1.hexdigest(temp)
      params[:user][:password_digest] = temp
    end
    if @host.update(user_params)
      if name != @host.name
        sql = "update comments set commenter = '" + @host.name + "' where user_id = '" + @host.id.to_s + "'"
        ActiveRecord::Base.connection.execute(sql)
      end
      redirect_to homes_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @host = User.find(params[:id])
    if @user != nil && @user.admin
      @host.destroy
    end
    redirect_to homes_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end
