Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :invoices
  resources :merchants
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
