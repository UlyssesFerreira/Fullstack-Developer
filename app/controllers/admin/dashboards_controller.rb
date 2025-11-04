class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @users_count = User.count
    @users_count_by_role = User.group(:role).count
    @users = User.all
  end
end
