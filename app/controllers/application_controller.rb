class ApplicationController < ActionController::Base
  before_action :config_permitted_parameters, if: :devise_controller?

  protected

  def config_permitted_parameters
    #strong parametersを設定し、employee_numberを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number])
  end

  def after_sign_in_path_for(resource)
    if company_signed_in?
      users_path(resource)
    else
      root_path
    end
  end

end
