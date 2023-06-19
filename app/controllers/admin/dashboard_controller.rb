class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_AUTHENTICATION_NAME"], password: ENV["ADMIN_AUTHENTICATION_PASS"]

  def show
  end
end
