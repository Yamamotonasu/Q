class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]
  include UsersHelper


  def show
    @user = User.find(params[:id])
    # トレード希望者を抽出する
    if has_question?
      @apply_user = Relation.where(answered_user_id: current_user.id)
      # 現在ターゲットになっている質問
      @my_target_question = Question.find_by(user_id: current_user.id, target: true)
      @my_answer_one = Answer.where(answer_result: @my_target_question.num_one, target: true).count
      @my_answer_two = Answer.where(answer_result: @my_target_question.num_two, target: true).count
      @my_answer_three = Answer.where(answer_result: @my_target_question.num_three, target: true).count
      @my_answer_four = Answer.where(answer_result: @my_target_question.num_four, target: true).count
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "新規登録しました！次に質問を投稿してみませんか？"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :new_image, :prefecture, :age, :sex)
    end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
