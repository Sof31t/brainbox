Timetracker::Application.routes.draw do

class SubdomainRoute

  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end

end

class NoSubdomainRoute

  def self.matches?(request)
    !request.subdomain.present?
  end

end

devise_for :users
resources :accounts
resources :users


constraints(SubdomainRoute) do		  
	 devise_scope :user do
	 	#get '/', to: "devise/session#new", as: 'custom_root'
	 	#get '/',  to: "custom#home", as: 'custom_root'
		 root :to => 'devise/sessions#new', as: 'subdomain_root'
	end
end

 	 root to: "welcome#index", as: "root" 




	
end
