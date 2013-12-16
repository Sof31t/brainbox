Timetracker::Application.routes.draw do

# class SubdomainRoute

#   def self.matches?(request)
#     request.subdomain.present? && request.subdomain != "www"
#   end

# end

# class NoSubdomainRoute

#   def self.matches?(request)
#     !request.subdomain.present?
#   end

# end

  devise_for :users
  resources :accounts
  resources :users
  root 'welcome#index'
  
# constraints(NoSubdomainRoute) do
#      root 'welcome#index'
#   end

#  constraints(SubdomainRoute) do
#      root 'new_user_session_path'
# end


end
