class Brainbox < ActiveRecord::Base

belongs_to :account

validates :name, presence: true
validates :descr, presence: true

end
