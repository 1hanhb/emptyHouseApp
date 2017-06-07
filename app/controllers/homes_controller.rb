class HomesController < ApplicationController
	def index
		@user = current_user
		@users = User.all
		@home = Home.all
	end

	def new
		@home = Home.new
	end

	def create
		@user = current_user
		if @home = @user.homes.create(home_params)
    	redirect_to user_home_path(@user,@home)
		else
			render 'new'
		end
	end

	def show
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		@user = current_user
	end

	def edit
		@user = current_user
		@home = Home.find(params[:id])
	end

	def update
		@user = current_user

		if @home = @user.homes.update(home_params)
			redirect_to user_home_path(@user,@home)
		else
			render 'edit'
		end
	end

	def destroy
		@home = Home.find(params[:id])
		@home.destroy
		redirect_to homes_path

	end

	private
		def home_params
			params.require(:home).permit(:title, :housingType, :houseAddress, :housingDeposit, :monthlyFee, :otherDescription, :avatar)
		end
end
