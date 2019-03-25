class MailActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      unless current_user
        log_in user
      end
      flash[:notice] = "メールアドレスを有効化しました。"
      redirect_to user
    else
      flash[:alert] = "無効なメールアドレスです。"
      redirect_to root_path
    end
  end
end
