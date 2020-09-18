# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

    # POST /resource

  def new 
    @user = User.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    @user = User.new(sign_up_params) #Userモデルのインスタンスを生成し、1ページ目から送られてきたパラメータをインスタンス変数@userに代入
    unless @user.valid? # そのインスタンス変数に対してvalid?メソッドを適用することで送られてきたパラメータが指定されたバリデーションに違反しないかどうかチェック
      flash.now[:alert] = @user.errors.full_messages # falseになった場合は、エラーメッセージとともにnewアクションへrender
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes} # 1ページ目で入力した情報のバリデーションチェックが完了したら、session["devise.regist_data"]に値を代入
    #sessionにハッシュオブジェクトの形で情報を保持させるために、attributesメソッドを用いてデータを整形
    session["devise.regist_data"][:user]["password"] = params[:user][:password] # paramsの中にはパスワードの情報は含まれているが、attributesメソッドでデータ整形をした際にパスワードの情報は含まれていない。そこで、パスワードを再度sessionに代入する必要がある
    @address = @user.build_shipping_info
    render :new_address #登録2ページ目に遷移
  end

  

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = ShippingInfo.new(shipping_info_params)
    unless @address.valid? # valid?メソッドを用いて、バリデーションチェックを行う。
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_shipping_info(@address.attributes) # build_shipping_infoを用いて送られてきたparamsを、保持していたsessionが含まれる@userに代入。そしてsaveメソッドを用いてテーブルに保存。
    @user.save!
    session["devise.regist_data"]["user"].clear # clearメソッドを用いて明示的にsessionを削除。
    sign_in(:user, @user) # ユーザーの新規登録ができても、ログインができているわけではない。それをsign_inメソッドを利用してログイン作業を行う。

  end

  protected

  
  def shipping_info_params
    params.require(:shipping_info).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postcode, :prefecture, :city, :house_number, :building, :home_call_num)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
