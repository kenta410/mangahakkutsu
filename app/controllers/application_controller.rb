class ApplicationController < ActionController::Base


  private

  def after_sign_in_path_for(resource)
    customer_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_saitizer.permit(:sign_up, keys: [:email])
  end
end
