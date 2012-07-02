ActiveAdmin.register Myavatar do
  form :html => {"multipart" => true } do |f|
		f.inputs "Myavatars" do
	    f.input :avatar, :as => :file
		end
		f.buttons
  end
end
