Rails.application.routes.draw do

	resources :appearance, only: [:show] # cria uma rota para a Appearance. Usa apenas GET SHOW, protegendo assim contra ataques.
  	
end
