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
  root 'welcome#index'

  get '/calc' => 'welcome#calc', as: :calc
  post '/calc' => 'welcome#calc'
end
