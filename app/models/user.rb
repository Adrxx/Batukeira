class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [ :capturist, :admin ]

  # Every user can update its password

  # Capturist can only update database records
  # Admin have all capturists privileges and have control over capturists accounts (create, update, destroy) // ALL PERMISSIONS
  # Super Admins have all admin privileges and have control over admin accounts (create, update, destroy) //NOT ANYMORE

  devise :database_authenticatable, :rememberable
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, confirmation: true
  validates :password, length: { in: 6..30 }
  validates :email, uniqueness: true

end
