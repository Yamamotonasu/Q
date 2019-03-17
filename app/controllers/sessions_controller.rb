class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: "#{params[:session][:name]}")
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "ログインしました。ようこそ、#{user.name}さん。"
      redirect_to user
    else
      flash.now[:alert] = "無効な名前かパスワードです。"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end
