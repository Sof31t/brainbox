class UsersController < ApplicationController

	private 
		def account_params
			params.require([:name, :email, :password, :password_confirmation])
		end

end
