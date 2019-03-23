class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def show
    @user = User.find_by(id: current_user.id)
    @my_question = Question.find_by(id: params[:id])
    #回答結果を集計する為の処理
    @my_answer_one = Answer.where(answer_result: @my_question.num_one, target: true).count
    @my_answer_two = Answer.where(answer_result: @my_question.num_two, target: true).count
    @my_answer_three = Answer.where(answer_result: @my_question.num_three, target: true).count
    @my_answer_four = Answer.where(answer_result: @my_question.num_four, target: true).count
  end

  def index
    @my_target_question = Question.find_by(user_id: current_user.id, target: true)
    @my_questions = Question.where(user_id: current_user.id, target: false)
    @user = User.find(current_user.id)
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
      flash[:notice] = "投稿に成功しました！続いて質問をトレードしてみましょう！"
      redirect_to user_questions_trade_path
    else
      render 'new'
    end
  end

  def enable
    true_question = Question.find_by(user_id: current_user.id, target: true)
    true_question.update_attribute(:target, false)
    my_question = Question.find_by(id: params[:id], target:false)
    my_question.update_attribute(:target, true)
    flash[:notice] = "トレードする質問を変更しました。"
    redirect_to current_user
  end

  def trade
    @target_questions = Question.where.not(user_id: current_user).where(target: true).find_nil.or(Question.where.not(user_id: current_user).find_other(current_user)).order("RANDOM()").limit(10).uniq
  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
