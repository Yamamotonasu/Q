require 'rails_helper'

describe '全ページを網羅的に辿る', type: :system do
  it 'ログインして全ページへ網羅的にアクセスする' do
    create(:user)
    visit root_path
    click_link 'ログイン'
    fill_in 'session[name]', with: 'tester'
    fill_in 'session[password]', with: 'testtesttest'
    click_button 'ログイン'
    click_link '新しい質問を投稿する'
    fill_in 'question[content]', with: '初デートはどこがいい？'
    fill_in '1', with: 'はい'
    fill_in '2', with: 'いいえ'
    click_button 'この内容で投稿する'
    expect(page).to have_content 'もう一度質問を探す'
    expect(page).to have_content 'あなたのページへ戻る'
    click_link 'tester'
    click_link 'あなたの投稿した質問'
    click_link '初デートはどこがいい？'
    click_link 'あなたの情報を更新する'
  end
end