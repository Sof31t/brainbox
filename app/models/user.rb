class User < ActiveRecord::Base
  	
  	#
  	# Constantes
  	#
	ROLES = %w(admin user)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	#
	# Associations
	# 	
 	belongs_to :account, foreign_key: 'account_id'

	#
	# Devise configuration   (Include default devise modules. Others available are:
 	# 					:confirmable, :lockable, :timeoutable, :omniauthable and :validatable)
	#
 	devise :database_authenticatable, :recoverable, :rememberable 


 	#
 	# Before callbacks
 	#
 	before_validation :downcase_email	

 	#
 	# Validations (TODO : Voir comment envoyer des messages paramètrables)
 	#
 	validates :name, 	presence:  { :message => "Name required" }
  	validates :role, 	presence: true,
  					 	inclusion: { in: ROLES, messages: 'not a valid role' }  	
  	validates_uniqueness_of :email,	 :scope => :account_id,
  									 :case_sensitive => false
	validates_format_of :email,	 	:with  => Devise.email_regexp
	validates_presence_of   :password, :on=>:create
	validates_confirmation_of   :password, :on=>:create
	validates_length_of :password, :within => Devise.password_length, :allow_blank => true

 # protected
 #   def self.find_for_database_authentication(warden_conditions)
 #     conditions = warden_conditions.dup
 #     login = conditions.delete(:login)
 #     account_id = conditions.delete(:account_id)
 #     where(conditions).where(["lower(email) = :value", { :value => name.downcase }]).where("account_id = ?", account_id).first
 #   end
  
  private
	def downcase_email
		self.email = email.downcase if email.present?
	end
end
