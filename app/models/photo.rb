class Photo < ActiveRecord::Base
  belongs_to :case
  has_attached_file :photo_file,
  :styles => {
    :thumb => "200x200>" },
  :convert_options => {
    :thumb => "-quality 75 -strip" }
  validates_attachment :photo_file, :presence => true,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  default_scope { order(:order) }
end
