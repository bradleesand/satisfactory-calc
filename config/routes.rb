Rails.application.routes.draw do
  resources :machine_processes do
    collection do
      post :recipe_form
    end
  end
  resources :machines
  resources :recipe_inputs
  resources :recipes
  resources :resources do
    collection do
      put :reorder
    end
    member do
      get :resource_tree
      get :process_tree
    end
  end
  devise_for :admins

  get '/calc' => 'calc#calc', as: :calc
  post '/calc' => 'calc#calc'

  root 'calc#calc'
end
