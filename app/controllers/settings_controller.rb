class SettingsController < ApplicationController
  before_action :set_user

  def show
    render :show
  end

  def profile
  end

  def password
  end

  def update
    case params[:type]
    when 'profile'
      update_profile
    when 'password'
      update_password
    else
      render :show
    end
  end

  private
    def set_user
      @user ||= current_user
    end

    def user_params
      params.require(:user).permit(*User::ACCESSABLE_ATTRS)
    end

    def update_profile
      if @user.update(user_params)
        redirect_to setting_path, notice: '信息更新成功！'
      else
        flash[:error] = '更新失败！'
        render :profile
      end
    end

    def update_password
      if @user.update_with_password(user_params)
        redirect_to new_session_path(@user), notice: '密码更新成功，请重新登陆。'
      else
        flash[:error] = '更新失败！'
        render :password
      end
    end

end
