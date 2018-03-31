class DashboardsController < ApplicationController

  def index
    @sites = current_user.sites.order(created_at: :desc)
  end

end
