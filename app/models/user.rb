class User < ActiveRecord::Base
	#before actions
	before_save{ self.email = email.downcase }	

	#validation sur le nom
  validates :name,  presence: true, length: { maximum: 50 }
	
	#regexp pour l'adresse mail
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#validations sur l'email
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	
	validates :password, length: { minimum: 6 }
end
