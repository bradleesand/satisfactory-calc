Rails.application.routes.draw do
  resources :machine_processes
  resources :machines
  resources :recipe_inputs
  resources :recipes
  resources :resources do
    collection do
      put :reorder
    end
  end
  devise_for :admins

  get '/calc' => 'calc#calc', as: :calc
  post '/calc' => 'calc#calc'

  root 'calc#index'
end
