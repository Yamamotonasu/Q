class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @apply_user = Relation.where(answered_user_id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash.now[:notice] = "新規登録しました！次に質問を投稿してみませんか？"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:notice] = "プロフィール画像を更新しました。"
      redirect_to @user
    else
      render :show
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :new_image)
    end
end
