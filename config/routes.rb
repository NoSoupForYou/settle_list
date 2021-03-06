Rails.application.routes.draw do
  resources :set_lists do
    collection do
      get :generate
    end
  end

  resources :songs

  resources :artists do
    resources :set_lists
  end

  get 'tags/:tag', to: 'songs#index', as: :tag

  get 'home' => 'home#index'
  
  root 'home#index'
end
