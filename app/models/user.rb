class User < ActiveRecord::Base

#	attr_accessible :role

 	 # Include default devise modules. Others available are:
 	 # :confirmable, :lockable, :timeoutable and :omniauthable
 	devise :database_authenticatable, :recoverable, :rememberable, :validatable

 	validates :name, presence: true
 	#validates :role, presence: true
  
end
