require 'rails_helper'

RSpec.describe '記事へのいいね', type: :system do
  let(:user) { create(:user) }
  let(:article) { create(:article, :with_user) }

  it 'いいねが登録できること', :js do
    login_as user, scope: :user
    visit article_path(article)

    expect do
      find_by_id('articles-favorite').click
      expect(page).to have_selector('img[alt="いいね解除"]')
    end.to change(Favorite, :count).by(1)
    expect(page).to have_no_selector('img[alt="いいね登録"]')
  end

  it 'いいね削除できること', :js do
    create(:favorite, user:, article:)
    login_as user, scope: :user
    visit article_path(article)

    expect do
      find_by_id('articles-favorite').click
      expect(page).to have_selector('img[alt="いいね登録"]')
    end.to change(Favorite, :count).by(-1)
    expect(page).to have_no_selector('img[alt="いいね解除"]')
  end

  it 'ログインしていない時、いいねボタンをクリックするとログイン画面に遷移すること', :js do
    visit article_path(article)

    expect do
      find('.articles__favorite').click
    end.not_to change(Favorite, :count)
    expect(page).to have_current_path(new_user_session_path)
  end
end
