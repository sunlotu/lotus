class Admin::AccountController < Admin::BaseController
  before_action :set_user, only: [:edit, :update]
  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_account_index_path, notice: '修改成功！'
    else
      render :edit
    end
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*User::ACCESSABLE_ATTRS)
  end
end