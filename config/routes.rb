Rails.application.routes.draw do
  resources :calendar_events
  resources :expenses
  get 'dashboard/index'
  root :to =>  'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
