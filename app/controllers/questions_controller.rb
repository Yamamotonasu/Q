class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash.now[:notice] = "投稿に成功しました！続いて質問をトレードしてみましょう！"
      redirect_to user_questions_trade_path
    else
      render 'new'
    end
  end

  def trade
    @target_questions = Question.where.not(user_id: current_user).find_nil.or(Question.where.not(user_id: current_user).find_other(current_user)).order("RANDOM()").limit(5)
  end

  def apply
    # まだ自分の質問を取り出しているだけ。
    # @target_questions = Question.find_by_sql("SELECT questions.* FROM questions WHERE questions.user_id = answered_user_id (SELECT questions.*, answers.user_id as answered_user_id FROM questions RIGHT INNER JOIN answers WHERE questions.user_id = current_user.id ) ").uniq
    # p @should_answer.answers.answer_post_id # 答えないといけない質問のid
    # p @target_questions



  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
