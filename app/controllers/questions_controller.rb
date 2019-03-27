class QuestionsController < ApplicationController
  include UsersHelper
  include QuestionsHelper
  def new
    @question = Question.new
    @user = User.find_by(id: current_user.id)
  end

  def show
    @user = User.find_by(id: current_user.id)
    @my_question = Question.find_by(id: params[:id])
    #回答結果を集計する為の処理
    @my_answer_one = Answer.where(answer_result: @my_question.num_one, target: true).count
    @my_answer_two = Answer.where(answer_result: @my_question.num_two, target: true).count
    @my_answer_three = Answer.where(answer_result: @my_question.num_three, target: true).count
    @my_answer_four = Answer.where(answer_result: @my_question.num_four, target: true).count

    # 都道府県別回答者集計用
    user1 = Answer.where(answer_result: @my_question.num_one, target: true).pluck(:answer_id)
    user2 = Answer.where(answer_result: @my_question.num_two, target: true).pluck(:answer_id)
    user3 = Answer.where(answer_result: @my_question.num_three, target: true).pluck(:answer_id) if @my_answer_three != 0
    user4 = Answer.where(answer_result: @my_question.num_four, target: true).pluck(:answer_id) if @my_answer_four != 0
    # @user1_pref = User.where(id: user1).pluck(:prefecture).group_by(&:itself).map{ |k, v| [k, v.count] }.to_h.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    # @user2_pref = User.where(id: user2).pluck(:prefecture).group_by(&:itself).map{ |k, v| [k, v.count] }.to_h.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    # @user3_pref = User.where(id: user3).pluck(:prefecture).group_by(&:itself).map{ |k, v| [k, v.count] }.to_h.sort {|(k1, v1), (k2, v2)| v2 <=> v1 } if @my_answer_three != 0
    # @user4_pref = User.where(id: user4).pluck(:prefecture).group_by(&:itself).map{ |k, v| [k, v.count] }.to_h.sort {|(k1, v1), (k2, v2)| v2 <=> v1 } if @my_answer_four != 0
    @user1_pref = count_prefecture(@my_question, 1)
    @user2_pref = count_prefecture(@my_question, 2)
    @user3_pref = count_prefecture(@my_question, 3) if @my_answer_three != 0
    @user4_pref = count_prefecture(@my_question, 4) if @my_answer_four != 0


    # 年齢層
    # choice1_age = User.where(id: user1).pluck(:age)
    # choice2_age = User.where(id: user2).pluck(:age)
    # choice3_age = User.where(id: user3).pluck(:age) if @my_answer_three != 0
    # choice4_age = User.where(id: user4).pluck(:age) if @my_answer_four != 0
    @user1_age = count_age(@my_question, 1)
    @user2_age = count_age(@my_question, 2)
    @user3_age = count_age(@my_question, 3) if @my_answer_three != 0
    @user4_age = count_age(@my_question, 4) if @my_answer_four != 0

    # 性別
    choice_sex1 = User.where(id: user1).pluck(:sex)
    choice_sex2 = User.where(id: user2).pluck(:sex)
    choice_sex3 = User.where(id: user3).pluck(:sex) if @my_answer_three != 0
    choice_sex4 = User.where(id: user4).pluck(:sex) if @my_answer_four != 0
    @user1_sex = sex_group_graph(choice_sex1)
    @user2_sex = sex_group_graph(choice_sex2)
    @user3_sex = sex_group_graph(choice_sex3) if @my_answer_three != 0
    @user4_sex = sex_group_graph(choice_sex4) if @my_answer_four != 0

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

  def destroy
    @question = Question.find(params[:id])
    if @question.target == true
      flash[:alert] = "トレード中の質問は削除出来ません。"
      redirect_to root_path
    else
      @question.destroy
      flash[:alert] = "質問を削除しました"
      redirect_to root_path
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
    if has_question?
      # @target_questions = Question.where.not(user_id: current_user).where(target: true).find_nil.and(Question.where.not(user_id: current_user)
      # .find_other(current_user)).order("RANDOM()").limit(10).uniq
          #自分の直前に投稿したデータのidを取ってくる
      @target_questions = []
      qs = Question.where.not(user_id: current_user.id).where(target: true)
      qs.each do |q|
        a = q.answers.find_by(answer_id: current_user.id)
        if a.blank?
          @target_questions << q
        end
      end
      return @target_questions
    else
      flash[:alert] = "先に質問を投稿してください"
      redirect_to current_user
    end
  end

  def other
    @my_question = Question.find_by(id: params[:ques])
    @my_answer_one = Answer.where(answer_result: @my_question.num_one, target: true).count
    @my_answer_two = Answer.where(answer_result: @my_question.num_two, target: true).count
    @my_answer_three = Answer.where(answer_result: @my_question.num_three, target: true).count
    @my_answer_four = Answer.where(answer_result: @my_question.num_four, target: true).count
  end

  private

  def question_params
    params.require(:question).permit(:content, :num_one, :num_two, :num_three, :num_four)
  end
end
