class Admin::MapsController < ApplicationController
	layout 'admin'
	before_filter :requires_authentication
	before_filter :load_map, :only => [:edit, :update, :destroy]
	set_tab :maps


	def index
	  if params[:site].present?
	    @maps = Map.joins(:site_maps).where({ :site_maps => { :site_id => params[:site]}}).paginate(:page => params[:page], :per_page => 10).order("year")
		else
		  @maps = Map.paginate(:page => params[:page], :per_page => 10).order("year")
	  end
		
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
		@map = Map.find_by_year(params[:id])
	end

end
