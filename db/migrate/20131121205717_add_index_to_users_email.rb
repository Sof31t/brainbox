class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	#On ajoute un index sur la colonne email de la table users
  	#On s'assure de son unicité 
  	add_index :users, :email, unique: true
  end
end
