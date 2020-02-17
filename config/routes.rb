Rails.application.routes.draw do
  resources :machine_processes
  resources :machines
  resources :recipe_inputs
  resources :recipes
  resources :resources
  devise_for :admins
  root 'welcome#index'
end
