ActiveAdmin.register BirthdayImage do
  form :html => {"multipart" => true } do |f|
		f.inputs "BirthdayImages" do
	    f.input :avatar, :as => :file
		end
		f.buttons
  end
end
