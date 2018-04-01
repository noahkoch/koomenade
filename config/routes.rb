Rails.application.routes.draw do
  devise_for :users

  root to: "dashboards#index"

  resources :sites do
    resources :documents
    resources :folders
  end

  get ":username/:site_name/*document_path", to: "sites#render_view", as: :render_view

  post ":username/:site_name/*document_path", to: "sites#post_values"
end
