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

    # 後々ActiveRecordでデータを取ってくるようにすること

    # 自分の直前に投稿したデータのidを取ってくる
    # @my_post_id = current_user.questions.first.id
    # @target_questions = []
    # qs = Question.where.not(user_id: current_user.id)
    # qs.each do |q|
    #   a = q.answers.find_by(user_id: current_user.id)
    #   if a.blank?
    #     @target_questions << q
    #   end
    # end
    # return @target_questions
  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
