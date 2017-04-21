class Dashboard < ApplicationRecord
  after_create_commit { DashboardsChannelJob.perform_later self }
end
