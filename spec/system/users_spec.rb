require 'rails_helper'

RSpec.describe 'ユーザー', type: :system do
  describe 'ユーザー新規登録・ログイン・パスワードリセット' do
    it '新規登録できること' do
      visit new_user_registration_path

      fill_in 'user[name]', with: '田中太郎'
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      expect do
        click_on '登録する'
      end.to change(User, :count).by(1)

      mail = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq ['user@example.com']
      expect(mail.from).to eq ['noreply@example.com']
      expect(mail.subject).to eq 'アカウント有効化について'
      expect(mail.body).to match 'アカウントを有効化する'
    end

    it 'アカウント有効化メールが再送できること' do
      create(:user, :unconfirmed, email: 'user@example.com')
      visit new_user_confirmation_path

      fill_in 'user[email]', with: 'user@example.com'
      expect do
        click_on 'アカウント有効化メールを再送する'
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      mail = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq ['user@example.com']
      expect(mail.from).to eq ['noreply@example.com']
      expect(mail.subject).to eq 'アカウント有効化について'
      expect(mail.body).to match 'アカウントを有効化する'
    end

    it 'パスワード再設定のメールが送信されること' do
      create(:user, email: 'user@example.com')
      visit new_user_password_path

      fill_in 'user[email]', with: 'user@example.com'
      expect do
        click_on 'パスワードの再設定メールを送信する'
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      mail = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq ['user@example.com']
      expect(mail.from).to eq ['noreply@example.com']
      expect(mail.subject).to eq 'パスワードの再設定について'
      expect(mail.body).to have_link 'パスワードを変更する'
    end
  end

  describe 'ユーザー詳細ページ' do
    let(:user) { create(:user) }

    it '公開された記事のみ表示されていること' do
      other_user = create(:user, email: 'kuma@example.com')
      create(:article, user:, title: '自分の公開記事')
      create(:article, :unpublished, user:, title: '自分の非公開記事')
      create(:article, user: other_user, title: '他のユーザーの公開記事')
      create(:article, :unpublished, user: other_user, title: '他のユーザーの非公開記事')
      login_as user, scope: :user
      visit user_path(other_user)

      expect(page).to have_no_content('自分の公開記事')
      expect(page).to have_no_content('自分の非公開記事')
      expect(page).to have_content('他のユーザーの公開記事')
      expect(page).to have_no_content('他のユーザーの非公開記事')
    end

    describe 'いいねした記事' do
      let(:other_user) { create(:user, email: 'kuma@example.com') }

      before do
        article = create(:article, user:, title: 'いいねされている記事')
        create(:article, user: other_user, title: 'いいねされていない公開記事')
        create(:favorite, user:, article:)
        login_as user, scope: :user
      end

      it 'そのユーザーがいいねした記事が表示できること' do
        visit user_path(user)
        click_on 'いいねした記事'

        expect(page).to have_content 'いいねされている記事'
        expect(page).to have_no_content 'いいねされていない記事'
      end

      it 'いいねした記事がない場合は表示されないこと' do
        visit user_path(other_user)
        click_on 'いいねした記事'

        expect(page).to have_content 'いいねした記事はありません'
        expect(page).to have_no_content 'いいねされている記事'
        expect(page).to have_no_content 'いいねされていない記事'
      end
    end

    describe 'フォロー・フォロワー', :js do
      let(:other_user) { create(:user, email: 'kuma@example.com') }

      before do
        login_as user, scope: :user
      end

      it 'フォローできること' do
        visit user_path(other_user)

        expect(page).to have_content 'フォローする'
        expect do
          click_on 'フォローする'
          expect(page).to have_content 'フォロー解除'
        end.to change(Following, :count).by(1)
      end

      it 'フォロー解除できること' do
        create(:following, following_user: user, followed_user: other_user)
        visit user_path(other_user)

        expect(page).to have_content 'フォロー解除'
        expect do
          click_on 'フォロー解除'
          expect(page).to have_content 'フォローする'
        end.to change(Following, :count).by(-1)
      end
    end
  end
end
