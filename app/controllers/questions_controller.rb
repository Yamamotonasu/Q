class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def index
    @my_questions = Question.where(user_id: current_user.id)
    @user = User.find(current_user.id)
    @my_result = Answer.where(user_id: current_user.id).includes(:question).where
  end

  def create
    # targetは1ユーザーにつき1つの質問しかtrueにならない事。
    target_true = Question.where(user_id: current_user.id).where(target: true)
    if target_true
      target_true.update(target: false)
    end
    @question = current_user.questions.new(question_params)
    # 新規投稿は必ずtarget:をtrueにする
    @question.attributes = {
      target: true
    }
    if @question.save
      flash.now[:notice] = "投稿に成功しました！続いて質問をトレードしてみましょう！"
      redirect_to user_questions_trade_path
    else
      render 'new'
    end
  end

  def trade
    @target_questions = Question.where.not(user_id: current_user).where(target: true).find_nil.or(Question.where.not(user_id: current_user).find_other(current_user)).order("RANDOM()").limit(5).uniq
  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
