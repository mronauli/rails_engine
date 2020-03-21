Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
      end
      resources :items, except: [:new, :edit]
      resources :merchants, except: [:new, :edit]
    end
  end
end
