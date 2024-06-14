require 'rails_helper'

RSpec.describe '記事', type: :system do
  describe '記事一覧ページ' do
    let(:user) { create(:user) }

    it '記事が表示されること' do
      create(:article, user:, title: '表示される記事')
      visit root_path

      expect(page).to have_content('表示される記事')
    end

    it '非公開記事が表示されないこと' do
      other_user = create(:user, email: 'kuma@example.com')
      create(:article, user:, title: '自分の公開記事')
      create(:article, :unpublished, title: '自分の非公開記事')
      create(:article, user: other_user, title: '他のユーザーの公開記事')
      create(:article, :unpublished, user: other_user, title: '他のユーザーの非公開記事')
      login_as user, scope: :user
      visit root_path

      expect(page).to have_content('自分の公開記事')
      expect(page).to have_no_content('自分の非公開記事')
      expect(page).to have_content('他のユーザーの公開記事')
      expect(page).to have_no_content('他のユーザーの非公開記事')
    end
  end
end
