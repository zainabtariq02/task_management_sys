Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :tasks do
    member do
      post :in_progress
      post :complete
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  scope '/admin' do
    resources :users
  end
end
  