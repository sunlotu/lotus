class AccountController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def extend
  end
end
