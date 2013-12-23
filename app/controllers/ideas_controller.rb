class IdeasController < ApplicationController
	
	def initialize
		self.thumbs_up=0
		self.thumbs_down=0
	end

	def destroy
		 @deleted_idea = Idea.find(params[:id])
 		 @deleted_idea.destroy
 		 redirect_to admin_path, notice: "Idée supprimé !"
 		 #Supprimer les idées
	end

	private 
		def account_params
			params.require([:name, :content])
		end

end
