require 'rails_helper'

describe 'Questions', type: :system do
  context '質問投稿' do
    it '質問を投稿した後トレード画面へ移行出来ること' do
      create(:user)
      visit root_path
      click_link 'ログイン'
      fill_in 'session[name]', with: 'tester'
      fill_in 'session[password]', with: 'testtesttest'
      click_button 'ログイン'
      click_link '新しい質問を投稿する'
      click_button 'ランダムで質問を生成する'
      fill_in '1', with: 'はい'
      fill_in '2', with: 'いいえ'
      click_button 'この内容で投稿する'
      expect(page).to have_content 'もう一度質問を探す'
      expect(page).to have_content 'あなたのページへ戻る'
    end
  end
end