class HomesController < ApplicationController
	def index

		temp = User.all
		temp.each do |user|
			if user.email == 'admin'
				User.setExistedAdmin(true)
				break
			end
		end

		if !User.getExistedAdmin
			admin = User.new(:name => 'admin', :email => 'admin', :password_digest => Digest::SHA1.hexdigest('admin'));
			admin.save!(:validate => false)
			#user = User.create!(:name => 'admin', :email => 'admin', :password_digest => Digest::SHA1.hexdigest('admin')
			User.setExistedAdmin(true)

		end
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
		if @user !=nil && @user.admin
		elsif @user == nil || @host.id != @user.id
			redirect_to homes_path
		end
	end

	def update
		@user = current_user
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		if @user == nil
			redirect_to homes_path
		elsif @user.admin || @user.id == @host.id
			if @home.update(home_params)
				redirect_to user_home_path(@host,@home)
			else
				render 'edit'
			end
		end
	end

	def destroy
		@user = current_user
		@home = Home.find(params[:id])
		@host = User.find(@home.user_id)
		if @user != nil && (@user.admin || @user.id = @host.id)
			@home.destroy
		end
		redirect_to homes_path
	end

	private
		def home_params
			params.require(:home).permit(:title, :housingType, :houseAddress, :housingDeposit, :monthlyFee, :otherDescription, :lat, :lng, :avatar, :detailedAddress)
		end
end
