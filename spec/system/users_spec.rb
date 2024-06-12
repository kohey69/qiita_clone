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
end
