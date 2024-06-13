Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
  }
  root 'home#index' # TODO: 仮のrootなので記事一覧が作成できたらそっちに変更する

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
