class Photo < ActiveRecord::Base
  belongs_to :case
  has_attached_file :photo_file
  do_not_validate_attachment_file_type :photo_file
  default_scope { order(:order) }
end
