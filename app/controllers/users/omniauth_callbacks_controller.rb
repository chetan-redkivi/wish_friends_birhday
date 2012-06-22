class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	require 'koala'
  def facebook
		data = request.env["omniauth.auth"].extra.raw_info
		session[:access_token] = request.env["omniauth.auth"].credentials.token
		if data.email.nil?
				@email = data.link
		else
			@email = data.email
		end
		if @user = User.find_by_email(@email)
			@user
		else # Create a user with a stub password.
			@user = User.new
			@user.email = @email
			@user.encrypted_password = Devise.friendly_token[0,20]
			@user.save(:validate => false)
		end

		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "#{params[:action]}".capitalize
			sign_in_and_redirect @user, :event => :authentication
		else
			session["devise.#{params[:action]}_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
  end


end
