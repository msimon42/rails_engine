Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/most_revenue', to: 'merchants#most_revenue'

      get '/invoices/find', to: 'invoices#find'
      get '/items/find', to: 'items#find'
      get '/transactions/find', to: 'transactions#find'
      get '/invoice_items/find', to: 'invoice_items#find'
      get '/customers/find', to: 'customers#find'
      get '/merchants/find', to: 'merchants#find'

      get '/invoices/find_all', to: 'invoices#find_all'
      get '/items/find_all', to: 'items#find_all'
      get '/transactions/find_all', to: 'transactions#find_all'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      get '/customers/find_all', to: 'customers#find_all'
      get '/merchants/find_all', to: 'merchants#find_all'

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
