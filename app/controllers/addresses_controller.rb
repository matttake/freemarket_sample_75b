class AddressesController < ApplicationController
  # ログイン状態且つ、addressテーブルにデータがある場合と無い場合で条件分岐
  # addressテーブルにデータがない場合(新規登録)
  def new
    if current_user && Address.find_by(user_id: current_user.id).present?
      @address = Address.find_by(user_id: current_user.id)
      render action: :edit
    else
      @address = Address.new
    end
  end
  
  def create
    @user = User.find_by(id: current_user[:id])
    @user_data = Address.find_by(user_id: current_user[:id])
    @address = Address.new(address_params)
    @address.save
    if @address.save
      flash[:notice] = "お届け先住所を登録しました"
      redirect_to("/users/#{user_session}")
    else
      render 'new'
    end
  end
  # addressテーブルにデータがある場合 (入力欄に現在の初期値を表示)
  def edit
    @address = Address.find(current_user.addresses.first.id)
  end

  def update
    @address = Address.find(current_user.addresses.first.id)
    if @address.update(address_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to("/users/#{user_session}")
    else
      render 'edit'
    end
  end

  private
  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_reading, :last_name_reading, :zip_code, :prefectures, :city, :address_line1, :address_line2).merge(user_id: current_user.id)
  end

end
