PointOut::Application.routes.draw do

  resources :issues
  resources :users
  resources :sessions

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  #root :to => "users#new"
  root :to => "sessions#new"

end
