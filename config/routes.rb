Rails.application.routes.draw do
  resources :set_lists

  resources :songs

  resources :artists do
    resources :set_lists
  end

  get 'tags/:tag', to: 'songs#index', as: :tag

  get 'home' => 'home#index'
  
  root 'home#index'
end
