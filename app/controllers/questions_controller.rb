class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:notice] = "投稿に成功しました！続いて質問をトレードしてみましょう！"
      redirect_to user_questions_trade_path
    else
      render 'new'
    end
  end

  def trade
    @target_questions = Question.where.not(user_id: current_user.id).order("RANDOM()").limit(5)
  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
