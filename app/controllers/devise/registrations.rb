module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :check_captcha

    private

    def check_captcha
      if !verify_rucaptcha?
        redirect_to new_user_session_path, alert: 'rucaptcha invaild'
        false
      else
        true
      end
    end
  end
end