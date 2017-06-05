class HomesController < ApplicationController
	def index
		@user = current_user
		@home = Home.all
	end

	def new
		@home = Home.new
	end

	def create
		@home = Home.new(home_params)

		@home.save
		redirect_to @home

	end

	def show
		@home = Home.find(params[:id])
	end

	def edit
		@home = Home.find(params[:id])
	end

	def update
		@home = Home.find(params[:id])

		if @home.update(home_params)
			redirect_to @home
		else
			render 'edit'
		end
	end

	def destroy
		@home = Home.find(params[:id])
		@home.destroy

	end

	private
		def home_params
			params.require(:home).permit(:title, :housingType, :houseAddress, :housingDeposit, :monthlyFee, :otherDescription, :avatar)
		end
end
