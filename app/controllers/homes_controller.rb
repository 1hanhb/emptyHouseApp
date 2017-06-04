class HomesController < ApplicationController
	def index
	end	

	def new
	end

	def create
		render plain: params[:movie].inspect
	end
end
