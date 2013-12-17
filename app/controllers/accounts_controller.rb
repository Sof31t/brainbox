class AccountsController < ApplicationController
	def new
		@account = Account.new
		@account.build_owner
	end

	def create		
		@account = Account.new(account_params)
		if @account.save
			redirect_to :account=>'home', notice: 'Signed up successfully'
		else
			render action: 'new'
		end
	end

	def index
	end
	
	def add_user
	end

	def remove_user
	end


	private 
		def account_params
			params.require(:account).permit(:subdomain, :subscription_type, owner_attributes: [:name, :email, :password, :password_confirmation])
		end

end
