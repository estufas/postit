class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  
  has_secure_password validations: false
  #validations: false will prevent has_secure_password from performing additional validations
  #will be adding them manually
  #if you want them don't specify validations: false
  
  validates :username, presence :true, uniqueness :true
  validates :password, presence :true, on: :create, length: {minimum: 3}
  #validate password only on creating the user
end