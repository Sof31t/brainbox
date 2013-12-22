class AccountsController < ApplicationController

	# Requiert l'identification sauf pour certaines méthodes
	before_filter :authenticate_user!, except: [:new, :create]
	authorize_resource :only => [:admin, :add_user, :remove_user,]


	def new
		#Création du compte
		@account = Account.new
		#Création de l'owner associé		
		@account.build_owner
	end

	def create	
		parameters = account_params
		@account = Account.new(parameters)
		@account.create_owner(parameters[:owner_attributes])
		if @account.save		
			redirect_to root_path, notice: "Signed up successfully ! Go on #{parameters[:subdomain]}.brainbox.dev to sign-in your new BrainBox !"
		else
			render action: 'new'
		end
	end

	def show
		@account = Account.where(subdomain: request.subdomain).take
	end
	
	def index
	end
	
	def admin
		@user = User.new
		@current_account = Account.where(subdomain: request.subdomain).take
		@users = User.where(account_id: @current_account.id).all
		@user = @current_account.users.build
	end

	def add_user
		@curr_account = Account.where(subdomain: request.subdomain).take
		if @curr_account.users.create(user_params)
			redirect_to admin_path, notice: "User added!"
		else
			redirect_to admin_path, alert: "Error!"
		end
		# if @current_account.save		
		# 	redirect_to account_path, notice: "Users added!"
		# else
		# 	render action: 'admin'
		# end
	end

	def remove_user
	end

	private 
		def account_params
			params.require(:account).permit(:subdomain, :subscription_type, owner_attributes: [:name, :role, :email, :password, :password_confirmation], user_attributes: [:name, :role, :email, :password, :password_confirmation])
		end
		def user_params
			params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
		end

	
end
