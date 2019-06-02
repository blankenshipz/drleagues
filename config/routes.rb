Rails.application.routes.draw do
  resources :leagues, only: [:show, :create, :edit, :new] do
    resources :models
    resources :teams
  end

  root 'leagues#index'
end
