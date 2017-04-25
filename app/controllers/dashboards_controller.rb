class DashboardsController < ApplicationController
  def index
    @dashboard = Dashboard.new
    @dashboards = Dashboard.all
  end

  def create
    @dashboard = Dashboard.create! dashboard_params
    redirect_to dashboards_path
  end

  def destroy
    set_dashboard
    @dashboard.delete
    redirect_to dashboards_path
  end

  private

  def set_dashboard
    @dashboard ||= Dashboard.find(params[:id])
  end

  def dashboard_params
    params.require(:dashboard).permit(:body)
  end

end
