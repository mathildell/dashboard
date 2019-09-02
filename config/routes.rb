Rails.application.routes.draw do
  resources :homes, only: [:index, :destroy]
  resources :people, only: [:index, :destroy]

  resources :expenses, only: [:index, :destroy, :new]
  post 'expenses/import' => 'expenses#import'

  get 'incomes/import' => 'incomes#import'
  post 'incomes/import' => 'incomes#import_func'
  resources :incomes#, only: [:index, :destroy, :new]
  #get 'expenses/:person' => 'expenses#index'


  get 'dashboard/index'
  root :to =>  'dashboard#index'

  # stfu rails
  get "/assets/bootstrap-grid.css.map" => redirect(json: 'stfu')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
