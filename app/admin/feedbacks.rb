ActiveAdmin.register Feedback do
  form do |f|
    f.inputs "Feedbacks" do
      f.input :name
      f.input :email
      f.input :comment
      f.input :fb_id
    end
    f.buttons
  end
end
