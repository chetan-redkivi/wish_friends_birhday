class HomeController < ApplicationController
  def index
		if !session[:access_token].nil?
			@graph = Koala::Facebook::API.new(session[:access_token])
			feed = @graph.get_connections("me", "feed")
			@friends_profile = @graph.get_connections("me", "friends", "fields"=>"name,birthday,gender")
			profile = @graph.get_object("me")
#			render :text =>profile.inspect and return false
			session[:image]= @graph.get_picture("me",:type=>"large")
			current_date = Date.today.strftime('%m-%d-%Y').split('-')
			@today_birthday = []
			@result = []
			upcomming = current_date[1].to_i+5
#			@friends_profile.each do |friend|
#				if !friend["birthday"].nil?
#					birthday = friend["birthday"].split('/')
#					if current_date[0] == birthday[0]
#						#month is same
#						if current_date[1]==birthday[1]
#							#Date is same
#							@today_birthday << friend["id"]
#						end
#					end
#				end
#			end
#			@today_birthday.each do |id|
#				@graph.put_wall_post("Wishing you a very special Birthday", {}, id)
#			end
	  end
	end
end
