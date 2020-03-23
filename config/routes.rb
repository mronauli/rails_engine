Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/revenue", to: "revenue#show"
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/most_revenue", to: "most_revenue#index"
        get "/most_items", to: "most_items#index"
        get "/revenue", to: "revenue#show"
      end
      resources :merchants, except: [:new, :edit] do
        member do
          get "/revenue", to: "merchants/revenue#show"
        end
        resources :items, module: :merchants, except: [:new, :edit]
      end
      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end
      get "/items/:item_id/merchant", to: "items/merchant#show"
      resources :items, except: [:new, :edit] do
        resources :merchant, module: :items, except: [:new, :edit, :index]
      end
    end
  end
end
