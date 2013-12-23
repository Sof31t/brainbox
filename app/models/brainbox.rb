class Brainbox < ActiveRecord::Base

	#
	# => Associations
	#
	belongs_to :account
	has_many :ideas

	#
	# => Validations
	#
	validates :name, presence: true
	validates :descr, presence: true

end
