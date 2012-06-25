class HomeController < ApplicationController
  def index
#  	render :text => params.inspect and return false
		@feedback = Feedback.new
		@testinomial = Feedback.find(:first)
		@json = Location.all.to_gmaps4rails
		if !session[:access_token].nil?
			@graph = Koala::Facebook::API.new(session[:access_token])
			@friends_profile = @graph.get_connections("me", "friends", "fields"=>"name,birthday,gender")
			@profile = @graph.get_object("me")
			session[:image]= @graph.get_picture("me",:type=>"large")
			@current_date = DateTime.now.new_offset(@profile["timezone"]/24).strftime('%m-%d-%Y').split('-')
			@today_birthday_ids = []
			@result = []
			@upcomming = @current_date[1].to_i+10
			@friends_profile.each do |friend|
				if !friend["birthday"].nil?
					birthday = friend["birthday"].split('/')
					if @current_date[0] == birthday[0]
						#month is same
						if @current_date[1]==birthday[1]
							#Date is same
							@today_birthday_ids << friend["id"]
						end
					end
				end
			end

			if !params["defaultMsz"].nil?
				@today_birthday_ids.each do |id|
					@graph.put_wall_post("Wishing you a very special Birthday", {}, id)
				end
				flash[:notice] = ""
			end
			if !params["customMsz"].nil?
				if !params["customMsz"].blank?
					@today_birthday_ids.each do |id|
						@graph.put_wall_post("#{params["customMsz"]}", {}, id)
					end
				else
					flash[:notice] = "Please Enter Your Quote it Should not Be blank :)"
				end

			end
	  end
	end

	def facefeed
		@graph = Koala::Facebook::API.new(session[:access_token])
		@graph.put_wall_post(params["feed"])
		redirect_to "/"
	end

	def addFeedback
		@feedback  = Feedback.new(params[:feedback])
		if @feedback.save
			redirect_to "/"
		else
		end
	end
end
