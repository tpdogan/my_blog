Rails.application.routes.draw do
  resources :taggings
  resources :authors
  root to: "articles#index"
  resources :articles do
    resources :comments
  end
end
