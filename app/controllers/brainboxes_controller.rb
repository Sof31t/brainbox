class BrainboxesController < ApplicationController

	def destroy
		 @deleted_bb = Brainbox.find(params[:id])
 		 @deleted_bb.destroy
 		 redirect_to admin_path, notice: "Brainbox supprimé !"
 		 #Supprimer les idées
	end


	private 
		def account_params
			params.require([:name, :descr])
		end

end
