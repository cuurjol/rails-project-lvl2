# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, except: %i[edit update] do
    resources :comments, only: :create
  end
end
