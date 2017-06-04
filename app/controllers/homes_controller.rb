class HomesController < ApplicationController
	def index
		@user = current_user
	end	

	def new
	end

	def create
	end
end
