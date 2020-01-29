Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/most_revenue', to: 'merchants#most_revenue'

      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchant_items#index'
        get '/invoices', to: 'merchant_invoices#index'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
