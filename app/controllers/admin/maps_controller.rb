class Admin::MapsController < ApplicationController
	layout 'admin'
	before_filter :requires_authentication
	before_filter :load_map, :only => [:edit, :update, :destroy]
	


	def index
		@maps = Map.paginate(:page => params[:page], :per_page => 10)
	end

	def edit
		
	end

	def update
		if @map.update_attributes(params[:map])
			redirect_to :action => :index
		else
			render :action => 'edit'
		end
	end

	def new
		@map = Map.new
	end

	def create
		@map = Map.new(params[:map])
		if @map.save
			redirect_to :action => :index
		else
			render :action => "new"
		end
	end

	def destroy
		@map.destroy
		redirect_to :action => :index
	end

	private

	def load_map
		@map = Map.find(params[:id])
	end

end
