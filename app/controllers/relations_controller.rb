class RelationsController < ApplicationController
  def apply
    # ログイン中のユーザーのIDをRelationsテーブルから取得したい
    @apply_users = Relation.where(answered_user_id: current_user.id, target: true).pluck(:question_id)
    @target_questions = Question.where(id: @apply_users, target: true)
  end

  def create
    my_true = Question.find_by(user_id: current_user.id, target: true)
    your_true = Question.find_by(id: params[:question_id], target: true)
    @answer = Answer.new
    @answer_id = params[:answer_id]
    @answer.attributes = {
      # 質問者のuser_id
      user_id: your_true.user_id,
      # 回答者のuser_id
      answer_id: current_user.id,
      # 回答結果
      answer_result: params[:choice],
      # 質問者の投稿ID
      question_id: params[:question_id],
      # 回答者の答えてほしい質問ID
      answer_post_id: my_true.id,
      # お互いの質問がtrueになった時に結果を反映させる為にtrueにする。
      target: true
    }
    @answer.save
    if @answer.answer_result.present?
      rel = Relation.find_by(answered_user_id: current_user.id, question_id: params[:question_id], target: true)
      rel.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      render :template => "/users/#{current_user.id}/apply_trade"
    end
  end
end
