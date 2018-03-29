Rails.application.routes.draw do
  devise_for :users

  root to: "dashboards#index"

  resources :contents, only: [:new, :create]

end
