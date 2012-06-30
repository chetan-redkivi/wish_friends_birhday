class HomeController < ApplicationController
  def index
#  	render :text => params.inspect and return false

		@feedback = Feedback.new
		@feedbacks = Feedback.find(:all)
		@testinomial = Feedback.find(1)
		@json = Location.all.to_gmaps4rails

		if !session[:access_token].nil?

			@graph = Koala::Facebook::API.new(session[:access_token])

			@friends_profile = @graph.get_connections("me", "friends", "fields"=>"name,birthday,gender")

			@profile = @graph.get_object("me")

		#	@graph.put_picture()
			session["id"] = @profile["id"]
			session[:image]= @graph.get_picture("me",:type=>"large")
			@current_date = DateTime.now.new_offset(@profile["timezone"]/24).strftime('%m-%d-%Y').split('-')
			@total_days = (Date.new(Time.now.year,12,31).to_date<<(12-(DateTime.now.strftime('%m')).to_i)).day
			@nxt_month_total_days = (Date.new(Time.now.year,12,31).to_date<<(12-(DateTime.now.strftime('%m')).to_i+1)).day
			@today_birthday_ids = []
			@result = []
			@today_birthday = []
			@next_month_bday=[]
			@nxt_result=[]
			@upcomming = @current_date[1].to_i+10
			#render :text => @friends_profile.inspect and return false
			@friends_profile.each do |friend|
				if !friend["birthday"].nil?
					birthday = friend["birthday"].split('/')
					if @current_date[0] == birthday[0]
						#month is same
						if @current_date[1]==birthday[1]
							#Date is same
							@today_birthday_ids << friend["id"]
							@today_birthday <<  {"name" => friend["name"],"birthday" => birthday[1],"id" => friend["id"]}
						end
						if birthday[1].to_i > @current_date[1].to_i && birthday[1].to_i < @upcomming
							@result << {"name" => friend["name"],"birthMonth"=>birthday[0],"birthday" => birthday[1]+" #{DateTime.now.new_offset(@profile["timezone"]/24).strftime('%B')}","id" => friend["id"]}
						end
						elsif birthday[0].to_i == @current_date[0].to_i+1
							if birthday[1].to_i >=1 && birthday[1].to_i < (@upcomming-@total_days.to_i)
								@nxt_result << {"name" => friend["name"],"birthMonth"=>birthday[0],"birthDate"=>birthday[1],"birthday" => birthday[1]+" #{(DateTime.now + 1.month).new_offset(@profile["timezone"]/24).strftime('%B')}","id" => friend["id"]}
							end
							@next_month_bday << {"name" => friend["name"],"birthday" => birthday[1],"id" => friend["id"]}
						end
					end
				end
				@result = @result.sort_by { |hsh| hsh["birthday"]}
				@nxt_result = @nxt_result.sort_by {|hsh| hsh["birthday"]}
				@result = @result+@nxt_result
				@next_month_bday = @next_month_bday.sort_by { |hsh| hsh["birthday"] }
			if !params["defaultMsz"].nil?
				@today_birthday_ids.each do |id|
					@graph.put_wall_post("Wishing you a very special Birthday", {}, id)
#				@graph.put_picture("/home/viinfo/Downloads/facebook.png", { "message" => "This is the photo caption" }, "id")

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
			@feedback.fb_id = session["id"]
			if @feedback.save
				redirect_to "/"
			else
			end
	end

	def testtime
		Date
	end

end
