Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelter#index'
  get 'shelters/new', to: 'shelter#new'
  get '/shelters/:id', to: 'shelter#show'
  post '/shelters', to: 'shelter#create'
  get '/shelters/:id/edit', to: 'shelter#edit'
  patch '/shelters/:id', to: 'shelter#update'
  delete '/shelters/:id', to: 'shelter#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'
end
