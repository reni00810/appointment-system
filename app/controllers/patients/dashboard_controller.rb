module Patients
  class DashboardController < ApplicationController
    before_action :authenticate_patient!

    def index
    end
  end
end
