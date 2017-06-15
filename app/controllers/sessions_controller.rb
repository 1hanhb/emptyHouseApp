class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      #redirect_to homes_path

      redirect_back_or_default(homes_path)
    else
      flash.now[:error] = '일치하는 아이디와 비밀번호가 존재하지 않습니다.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to homes_path
  end

end
