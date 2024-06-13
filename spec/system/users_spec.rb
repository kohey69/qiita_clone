require 'rails_helper'

RSpec.describe 'ユーザー新規登録・ログイン・パスワードリセット', type: :system do
  it '新規登録できること' do
    visit new_user_registration_path

    fill_in 'user[name]', with: '田中太郎'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    expect do
      click_on '登録する'
    end.to change(User, :count).by(1)
  end
end
