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
	validates_uniqueness_of :name,	 	:scope => :account_id,
  										:case_sensitive => false
	validates :descr, presence: true


end
