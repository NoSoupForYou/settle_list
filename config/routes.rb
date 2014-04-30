Rails.application.routes.draw do
  resources :songs

  resources :artists

  get 'tags/:tag', to: 'songs#index', as: :tag

  get 'home' => 'home#index'
  
  root 'home#index'
end
