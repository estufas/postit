class User < ActiveRecord::Base
  include Sluggable
  
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  #validations: false will prevent has_secure_password from performing additional validations
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}
  #uses virtual attribute
  #validate password only on creating the user
  #on: :create  user can edit profile without validating password
  
  sluggable_column :username
 
end