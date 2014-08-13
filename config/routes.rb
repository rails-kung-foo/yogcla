Rails.application.routes.draw do

	controller :sessions do
		get 	'login'		=> :new
		post	'login'		=> :create
		delete	'logout'	=> :destroy
	end

  resources :admins
  resources :courses
  resources :styles
  resources :studios

  root  'pages#home'


	match '/admin',  to: 'admins#index',  via: 'get' 
	match '/yoga-styles',  to: 'styles#index',  via: 'get' 
	match '/studios',  to: 'studios#index',  via: 'get' 
	match '/info',  to: 'pages#info',  via: 'get' 
	match '/courses',  to: 'courses#index',  via: 'get' 

  #redirect all wrong to root
  match '*path' => redirect('/'), via: :get
end
