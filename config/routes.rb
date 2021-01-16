Rails.application.routes.draw do
  get 'sources/index'
  get '/submit', to: 'sources#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
