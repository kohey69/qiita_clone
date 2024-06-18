Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
  }

  namespace :user do
    resources :articles
  end
  resources :articles, only: %i[show] do
    resource :favorite, only: %i[create destroy], module: :articles
  end
  resources :users, only: %i[show] do
    resource :following, only: %i[create destroy], module: :users
    resources :followings, only: %i[index], module: :users
  end
  resources :tags, only: %i[index]
  root 'articles#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
