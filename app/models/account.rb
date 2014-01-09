class Account < ActiveRecord::Base

	#
	# Constantes
	#

	RESTRICTED_SUBDOMAINS = %w(www)
	SUBSCRIPTION_TYPES = %w(free basic premium)

	#
	# Associations
	#

	has_one :owner, class_name: 'User' 
	has_many :users
	has_many :brainboxes

	#
	# Validations
	#

	validates :owner, presence: true

	validates :subdomain, 	presence: true,
							uniqueness: { case_sensitive: false },
							format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
							exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }
	
	validates :subscription_type, 	presence: true,
									 inclusion: { in: SUBSCRIPTION_TYPES, messages: 'not a valid subscription_type' }


	#
	# Before callbacks
	#		

	before_validation :downcase_subdomain		

	#
	# Accepts_nested_attributes 
	#			 
	
	accepts_nested_attributes_for :owner
	accepts_nested_attributes_for :users

	def bbs_max
		return 1 if self.subscription_type=="free"
		return 5 if self.subscription_type=="basic"
		return 10 if self.subscription_type=="premium"
	end

	def ideas_max
		return 5 if self.subscription_type=="free"
		return 10 if self.subscription_type=="basic"
		return 15 if self.subscription_type=="premium"
	end

	def users_max
		return 5 if self.subscription_type=='free'
		return 10 if self.subscription_type=='basic'
		return 15 if self.subscription_type=='premium'
	end

private
	def downcase_subdomain
		self.subdomain = subdomain.downcase if subdomain.present?
	end

end
