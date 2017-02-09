Rails.application.routes.draw do
  resources :lists do
    resources :tasks, only: [:new, :create, :destroy] do
      get "done", on: :member
    end
  end

  devise_for :users

  root 'lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
