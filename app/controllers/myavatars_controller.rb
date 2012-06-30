class MyavatarsController < ApplicationController
  def index
  end

  def new
  	@myavatar = Myavatar.new
  end

  def create
  	@myavatar = Myavatar.new(params[:myavatar])
  	if @myavatar.save
  		redirect_to "myavatars"
		else
			render :action => "new"
		end
  end

end
