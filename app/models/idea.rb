class Idea < ActiveRecord::Base

	#
	# => Associations
	#
	belongs_to :brainbox

	#
	# => Validations
	#
	validates :name, presence: true
	validates :content, presence: true
end
