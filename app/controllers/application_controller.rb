class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(Doctor)
      doctors_dashboard_path
    elsif resource.is_a?(Patient)
      patients_dashboard_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :name, :email, :phone, :password, :password_confirmation, :gender, :qualification, :address
      )
    end
  end

  def set_peginate
    @per_page = params[:per_page].to_i <= 0 ? PER_PAGE : params[:per_page].to_i
    @page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
  end
end
