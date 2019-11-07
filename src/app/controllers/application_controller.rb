class ApplicationController < ActionController::Base
    # if the devise controller is being accessed, calls the configure_permitted_parameters method.
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    
    # a devise method that configures the accepted parameters for a user sign up form.
    # the reason for using this is that I added a custom parameter of 'username' so I had to modify devise's accepted parameters.
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit(:username, :email, :password, :fname, :lname)
        end
    end

end
