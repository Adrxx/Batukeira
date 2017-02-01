class AddFeaturedToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :featured, :boolean
  end
end
