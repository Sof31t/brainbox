class AccountsController < ApplicationController
	#
	# => TODO : un meme email doit pouvoir être utiliser sur deux domaines différents
	# => Sécurité : enlever le rôle de l'hidden field et le définir à l'interieur du contrôleur
	#


	# Requiert l'identification sauf pour certaines méthodes
	before_filter :authenticate_user!, except: [:new, :create]
	authorize_resource :only => [:admin, :add_user, :remove_user]

	before_filter :get_current_account, :only =>[:show, :admin, :add_user, :add_bb]


	def get_current_account
		@current_account = Account.where(subdomain: request.subdomain).take
	end

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
		#@account = Account.where(subdomain: request.subdomain).take
		@bbs = Brainbox.where(account_id: @current_account.id)
		#Idea form
		@idea = Idea.new
	end
	
	def index
	end
	
	def admin
		#User form
		@user = User.new		
		@user = @current_account.users.build
		#Liste des users
		@users = User.where(account_id: @current_account.id).all
		#BB form
		@bb = Brainbox.new
		@bb = @current_account.brainboxes.build
		#Liste des bbs
		@bbs = Brainbox.where(account_id: @current_account.id).all		
	end

	def add_user		
		@current_account.users.build(user_params)
		if @current_account.save
			redirect_to admin_path , notice: "Utilisateur créé"
		else
			redirect_to admin_path, alert: "Erreur lors de la création de l'utilisateur"
			#flash[:errors]=@current_account.errors
			#render action: 'adm'
		end
	end

	def add_bb
		@bb = @current_account.brainboxes.build(bb_params)
		if @current_account.save
			redirect_to admin_path, notice: "BrainBox créée"
		else
			redirect_to admin_path, alert: "Erreur lors de la création de la BrainBox"
		end	
	end

	private 
		def account_params
			params.require(:account).permit(:subdomain, :subscription_type, owner_attributes: [:name, :role, :email, :password, :password_confirmation])
		end

	private
		def user_params
			params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
		end

	private
		def bb_params
			params.require(:brainbox).permit(:name, :descr)
		end

	
end
