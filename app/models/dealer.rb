class Dealer < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :telephone, format: { with: /\A[]\d\(\)\+\s]+\z/i}
  validates :telephone2, format: { with: /\A[]\d\(\)\+\s]+\z/i }, :allow_blank => true
   validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, :allow_blank => true
  
end
