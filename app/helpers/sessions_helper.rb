module SessionsHelper

  # 渡されたユーザーインスタンスでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookie[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # @current_userに何か値が入っている(ログイン済み)の場合trueを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続セッションを破棄する(ログアウト用)
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 渡されたユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLをsessionに格納しておく
  # request.origin_urlでgetリクエストを送信した時のみ記憶する
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end