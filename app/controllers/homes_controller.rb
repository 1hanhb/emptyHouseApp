class HomesController < ApplicationController
	def index
		@user = current_user
		@users = User.all
		@homes = Home.all
		@home = Home.all
	end

	def new
		@user = current_user
		@home = Home.new
	end

	def create
		@user = current_user
		@home = @user.homes.create(home_params)
		if @home.id != nil
    	redirect_to user_home_path(@user,@home)
		else
			render 'new'
		end
	end
	
	def show
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		@user = current_user
		if @user == nil
			store_return_to
		end
	end

	def edit
		@user = current_user
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		if @host.id != @user.id
			redirect_to homes_path
		end
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
		@user = current_user
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		if @host.id != @user.id
			redirect_to homes_path
		end
		@home.destroy
		redirect_to homes_path

	end

	private
		def home_params
			params.require(:home).permit(:title, :housingType, :houseAddress, :housingDeposit, :monthlyFee, :otherDescription, :lat, :lng, :avatar, :detailedAddress)
		end
end
