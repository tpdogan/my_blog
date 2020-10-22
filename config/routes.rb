Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles do
    resources :comments, only: [:create]
  end
  resources :authors, only: [:show]

  get '*path' => redirect('/')
  resources :taggings
end
