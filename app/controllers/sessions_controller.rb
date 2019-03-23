class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: "#{params[:session][:name]}")
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "ログインしました。ようこそ、#{user.name}さん。"
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:alert] = "無効な名前かパスワードです。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end
