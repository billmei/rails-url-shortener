Rails.application.routes.draw do
  root 'sources#index'
  resources :sources, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/:shortened_url', to: 'sources#show'
end
