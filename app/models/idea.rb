class Idea < ActiveRecord::Base

	#
	# => Associations
	#
	belongs_to :brainbox

	#
	# => Validations
	#
	validates :name, presence: true
	validates_uniqueness_of :name,	 	:scope => :brainbox_id,
  										:case_sensitive => false
	validates :content, presence: true

end
