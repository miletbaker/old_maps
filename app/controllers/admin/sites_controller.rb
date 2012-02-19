class Admin::SitesController < ApplicationController
  layout 'admin'
	before_filter :requires_authentication
	before_filter :load_site, :only => [:edit, :update, :destroy]
	set_tab :sites
	
	def index
		@sites = Site.paginate(:page => params[:page], :per_page => 10)
	end

	def edit
		
	end

	def update
		if @site.update_attributes(params[:site])
			redirect_to :action => :index
		else
			render :action => 'edit'
		end
	end

	def new
		@site = Site.new
	end

	def create
		@site = Site.new(params[:site])
		if @site.save
			redirect_to :action => :index
		else
			render :action => "new"
		end
	end

	def destroy
		@site.destroy
		redirect_to :action => :index
	end
	
	private

	def load_site
		@site = Site.find_by_id(params[:id])
	end
	
end
