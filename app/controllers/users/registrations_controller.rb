module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      super
    end

    protected

    def after_sign_up_path_for(_resource)
      root_path
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :department_id])
    end

    #
    # Override this method to have the form object as Devise's resource
    #
    def build_resource(permitted_params = {})
      session[:department_id] ||= params[:department_id]
      permitted_params.merge!(department_id: params[:department_id] || session[:department_id])

      self.resource = RegistrationForm.new(permitted_params)
    end
  end
end
