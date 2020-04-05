class DashboardController < ApplicationController
  def index
    @department = Department.first_or_create(name: 'Marketing')
  end
end
