class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  before_action :set_category

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
  
  # カテゴリ情報の取得(親要素のみ)
  def set_category
    @parents = Category.where(ancestry: nil)
  end
end
