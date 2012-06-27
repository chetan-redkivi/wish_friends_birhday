class AddFieldToFeedbacks < ActiveRecord::Migration
  def self.up
    remove_column :feedbacks, :user_fb_id
	  add_column :feedbacks, :fb_id, :string
  end

  def self.down
    remove_column :feedbacks, :fb_id
  end
end
