class AnswersController < ApplicationController
  # createアクションのみ外部からのリクエストを許可する。
  # protect_from_forgery :except => [:create]
  def result
  end

  def create
    @answer = Answer.new
    @answer_id = params[:answer_id]
    @answer.attributes = {
      user_id: current_user.id,
      answer_result: params[:choice],
      question_id: params[:question_id],
      answer_post_id: current_user.questions.first.id
    }
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
