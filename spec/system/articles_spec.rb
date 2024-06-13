require 'rails_helper'

RSpec.describe '記事', type: :system do
  describe '記事一覧ページ' do
    let(:user) { create(:user) }

    it '記事が表示されること' do
      create(:article, user:, title: '表示される記事')
      visit root_path

      expect(page).to have_content('表示される記事')
    end

    it '他のユーザーの記事が表示されること' do
      create(:article, user:, title: '表示される記事')
      other_user = create(:user, email: 'kuma@example.com')
      login_as other_user, scope: :user
      visit root_path

      expect(page).to have_content('表示される記事')
    end
  end
end
