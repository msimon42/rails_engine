Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customer, only: [:index, :show]
      resources :invoice_item, only: [:index, :show]
      resources :invoice, only: [:index, :show]
      resources :item, only: [:index, :show]
      resources :merchant, only: [:index, :show]
      resources :transaction, only: [:index, :show]
    end
  end     
end
