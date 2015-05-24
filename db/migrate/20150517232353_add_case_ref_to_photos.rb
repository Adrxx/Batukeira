class AddCaseRefToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :case, index: true
    add_foreign_key :photos, :cases
  end
end
