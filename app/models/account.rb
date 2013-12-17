class Account < ActiveRecord::Base
	RESTRICTED_SUBDOMAINS = %w(www)
	SUBSCRIPTION_TYPES = %w(free basic premium)

	belongs_to :owner, class_name: 'User' #specifié car noms différents, un compte appartient a un owner, admin

	has_many :user #et possède plusieurs utilisateurs

	validates :owner, presence: true

	validates :subdomain, 	presence: true,
							uniqueness: { case_sensitive: false },
							format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
							exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }
	
	validates :subscription_type, 	presence: true,
									 inclusion: { in: SUBSCRIPTION_TYPES, messages: 'not a valid subscription_type' }

	accepts_nested_attributes_for :owner

	before_validation :downcase_subdomain

private
	def downcase_subdomain
		self.subdomain = subdomain.downcase if subdomain.present?
	end

end
