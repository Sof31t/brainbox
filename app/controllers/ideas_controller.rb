class IdeasController < ApplicationController
	
	def initialize
	end

	def destroy
		 @deleted_idea = Idea.find(params[:id])
 		 @deleted_idea.destroy
 		 redirect_to admin_path, notice: "Idée supprimé !"
 		 #Supprimer les idées
	end

	def add_thumbs_up
		@idea = Idea.where(id=params[:idea_id]).take
		@user = User.where(id=params[:user_id]).take
		@user.vote_for(@idea);
		redirect_to root_path
	end

	def add_thumbs_down
		@idea = Idea.where(id=params[:idea_id]).take
		@user = User.where(id=params[:user_id]).take
		@user.vote_against(@idea);
		redirect_to root_path
	end

	private 
		def account_params
			params.require([:name, :content])
		end

end
