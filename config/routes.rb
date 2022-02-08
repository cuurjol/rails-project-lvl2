# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, only: %i[index new create show destroy] do
    resources :comments, only: :create
    resources :likes, only: %i[create destroy]
  end
end
