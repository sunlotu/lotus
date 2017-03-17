module Accessible
  extend ActiveSupport::Concern

  protected

  def check_user
    if current_admin
    else
      redirect_to account_path
    end
  end
end