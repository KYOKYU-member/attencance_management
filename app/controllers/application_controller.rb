class ApplicationController < ActionController::Base
  before_action :config_permitted_parameters, if: :devise_controller?

  protected

  def config_permitted_parameters
    #strong parametersを設定し、employee_numberを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number])
  end
end
