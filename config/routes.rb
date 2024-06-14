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
  resources :articles, only: %i[show]
  resources :users, only: %i[show]
  resources :tags, only: %i[index]
  root 'articles#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
