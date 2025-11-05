class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def show
    @users = User.all
  end
end
