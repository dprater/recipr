Rails.application.routes.draw do
  resources :ingredients
  resources :categories
  resources :recipes do
    get :search, :on => :collection
  end

  root 'recipes#index'
end
