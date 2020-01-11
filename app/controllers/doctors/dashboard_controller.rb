module Doctors
  class DashboardController < ApplicationController
    before_action :authenticate_doctor!

    def index
    end
  end
end
