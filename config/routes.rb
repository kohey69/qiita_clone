Rails.application.routes.draw do
  root 'home#index' # TODO: 仮のrootなので記事一覧が作成できたらそっちに変更する
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
