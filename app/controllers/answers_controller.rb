class AnswersController < ApplicationController
  def result
  end

  def create
    # 自分の答えてほしい質問を抽出してanswer_post_id(答えてほしい質問)へ格納する)
    my_true = Question.find_by(user_id: current_user.id, target: true)

    @answer = Answer.new
    @answer_id = params[:answer_id]
    @answer.attributes = {
      # 質問に回答した人のuser_id
      user_id: current_user.id,
      # 回答結果
      answer_result: params[:choice],
      # 質問者の投稿ID
      question_id: params[:question_id],
      # 回答者の答えてほしい質問ID
      answer_post_id: my_true.id,
      # お互いの質問がtrueになった時に結果を反映させる為にtrueにする。
      target: true
    }
    # 質問者のuser_idを抽出する為の処理
    your_answer = Question.find_by(id: params[:question_id], target: true)
    # relationsテーブルに答えてあげた相手のuser_idと自分の質問IDを格納する。
    Relation.create!(answered_user_id: your_answer.user.id, question_id: my_true.id, target: true, user_id: current_user.id)
    @answer.save
    if @answer.answer_result.present?
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      render :template => "/users/#{current_user.id}/questions/trade"
    end
  end
end
