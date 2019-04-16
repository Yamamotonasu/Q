require 'rails_helper'

describe '新規登録', type: :system do
  context '新規登録' do
    it '新規登録をした後必要な情報があること' do
      visit root_path
      click_link '新規登録'
      fill_in 'ユーザーネーム', with: 'test100'
      select '大阪府', from: 'user[prefecture]'
      fill_in '年齢', with: '27'
      select '男', from: 'user[sex]'
      fill_in 'パスワード', with: '123456'
      fill_in 'もう一度パスワードを入力', with: '123456'
      click_button '新規登録'
      expect(page).to have_content '新しい質問を投稿する'
      expect(page).to have_content 'test100'
      expect(page).to have_content 'ログアウト'
    end
  end

  context 'ログインとログアウト' do
    it 'テストuserが有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ログインとログアウトが出来ること' do
      create(:user)
      visit root_path
      click_link 'ログイン'
      fill_in 'session[name]', with: 'tester'
      fill_in 'session[password]', with: 'testtesttest'
      click_button 'ログイン'
      expect(page).to have_content 'tester'
      expect(page).to have_content 'ログアウト'
      click_link 'ログアウト'
      expect(page).to have_content 'ログイン'
      expect(page).to have_content '新規登録'
    end
  end
end