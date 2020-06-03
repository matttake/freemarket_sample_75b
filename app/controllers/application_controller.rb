class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_category
  before_action :set_current_user

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
  
  protected
  def configure_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :password_confirmation, :fast_name, :last_name, :fast_name_reading, :last_name_reading, :birth_date]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [ :email, :password]
  end

  # カテゴリ情報の取得(親要素のみ)
  def set_category
    @parents = Category.where(ancestry: nil)
  end
  # ログイン中のユーザを取得
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
