Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	root :to => "application#home"

	namespace :api do
	     post 'authenticate', to: 'authentication#authenticate'
	     get 'need_auth', to: 'authentication#need_auth'
	end

end
