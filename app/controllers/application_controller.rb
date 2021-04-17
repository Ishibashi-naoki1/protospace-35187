class ApplicationController < ActionController::Base
  # もしサインアップの時はデバイスコントローラーに情報を渡してください
  before_action :configure_permitted_parameters, if: :devise_controller?
  


  
  # 渡す情報はkeysの中身をレコードに保存してください
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
  
  # redirect_to controller: :"devise/registrations"サインアップに失敗した場合、元に戻す
  # unless user_signed_in?
  #   redirect_to user_registration_path
  # end
  
end