class User < ActiveRecord::Base

#	attr_accessible :role

 	 # Include default devise modules. Others available are:
 	 # :confirmable, :lockable, :timeoutable and :omniauthable
 	devise :database_authenticatable, :recoverable, :rememberable, :validatable

 	validates :name, presence: true
 	#validates :role, presence: true
  
  	# def self.roles
  	# 	@@roles
  	# end

	# def role<br> @@roles[self.role_id || 0]
 # 	end

	# def role(value)
	# 	if role_id = @@roles.index(value)
	# 		self.role_id = role_id
	# 	end
	# end

	# def is?(roles)
	# 	if roles.class.public_method_defined? :'include?'
	# 		role.include?
	# 	self.role<br> else
	# 		role==self.role
	# 	end
	# end
end
