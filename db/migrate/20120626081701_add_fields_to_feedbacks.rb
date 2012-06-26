class AddFieldsToFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :user_fb_id, :integer
  end

  def self.down
    remove_column :feedbacks, :user_fb_id
  end
end
