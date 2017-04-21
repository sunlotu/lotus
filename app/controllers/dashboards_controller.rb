class DashboardsController < ApplicationController
  def index
    @dashboard = Dashboard.new
    @dashboards = Dashboard.all
  end

  def create
    @dashboard = Dashboard.create! dashboard_params
    redirect_to dashboards_path
  end

  private

  def dashboard_params
    params.require(:dashboard).permit(:body)
  end

end
