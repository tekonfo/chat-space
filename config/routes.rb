Rails.application.routes.draw do

  resources :users,only: [:edit,:update]
  devise_for :users

##これはアクションに対するURLを変更してあげているだけだった

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'groups#index'

  patch "/users/update", :to => "users#update"
  resources :groups,:except => [:index]


end
