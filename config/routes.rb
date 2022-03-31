Rails.application.routes.draw do
  get "/api/v1/merchants/find"

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items, except: [:edit] do
        resources :merchant, only: [:index], controller: :item_merchant
      end
    end
  end
end
