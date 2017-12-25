Rails.application.routes.draw do


  devise_for :users

##これはアクションに対するURLを変更してあげているだけだった

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'groups#index'
  get "/users/edit2", :to => "users#edit"
  patch "/users/update", :to => "users#update"
  resources :groups,:except => [:index]


end
