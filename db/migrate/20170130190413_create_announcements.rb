class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :link
      t.text :image
      t.datetime :validity

      t.timestamps null: false
    end
  end
end
