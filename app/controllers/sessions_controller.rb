class SessionsController < ApplicationController
  def create
    # request.env['omniauth.auth']にはTwitterからユーザ情報やアクセストークンが渡される
    # ユーザがあれば取得し、なければ新規作成する
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    # セッションにユーザidを渡してログイン状態とする
    session[:user_id] = user.id
    redirect_to root_path, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
