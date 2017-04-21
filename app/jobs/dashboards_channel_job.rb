class DashboardsChannelJob < ApplicationJob
  queue_as :default

  def perform(dashboard)
    ActionCable.server.broadcast('dashboard', dashboard: render_dashboard(dashboard))
  end

  private

  def render_dashboard(dashboard)
    DashboardsController.renderer.render(partial: 'dashboards/dashboard', locals: { dashboard: dashboard })
  end
end
