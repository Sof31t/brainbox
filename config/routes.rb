Timetracker::Application.routes.draw do
	

	

#Routes dans le cas de la page d'accueil sans sous-domaine
	constraints(NoSubdomainRoute) do
		match '/signup', to: 'accounts#new', via: 'get'
		match '/accounts', to: 'accounts#create', via: 'post'
		root to: "welcome#index", as: "root"
	end

#Routes dans le cas d'un sous-domaine
	constraints(SubdomainRoute) do		
		devise_for :users
		
		devise_scope :user do
		#	root :to => 'devise/sessions#new', as: 'subdomain_root'
			root :to =>'accounts#show', as: 'subdomain_root'
			match '/admin', to: 'accounts#admin', via: 'get'
			match '/add_user', to: 'accounts#add_user', via: 'post'
		end	
		#match '/accounts/:id', to: 'accounts#new', via: 'get'
		resources :accounts
		resources :users
	end

 

end
