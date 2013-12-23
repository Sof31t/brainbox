class BrainboxesController < ApplicationController

	def destroy
		 @deleted_bb = Brainbox.find(params[:id])
 		 @deleted_bb.destroy
 		 redirect_to admin_path, notice: "Brainbox supprimé !"
 		 #Supprimer les idées
	end

	def add_idea
		@brainbox = Brainbox.where(id: idea_params[:brainbox_id]).take
		@brainbox.ideas.build(idea_params)
		if @brainbox.save
			redirect_to root_path, notice: "Idea added!"
		else
			redirect_to root_path, alert: "Error!"
		end
	end


	private
		def idea_params
			params.require(:idea).permit(:name, :content, :brainbox_id)
		end

end
