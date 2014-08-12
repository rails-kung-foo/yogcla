Rails.application.routes.draw do

  resources :courses

	resources :styles
	resources :studios

	root  'pages#home'



	match '/yoga-styles',  to: 'styles#index',  via: 'get' 
	match '/studios',  to: 'studios#index',  via: 'get' 
	match '/info',  to: 'pages#info',  via: 'get' 
	match '/courses',  to: 'courses#index',  via: 'get' 

  #redirect all wrong to root
  match '*path' => redirect('/'), via: :get
end
