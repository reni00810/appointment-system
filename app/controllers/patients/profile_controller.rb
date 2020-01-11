module Patients
  class ProfileController < ApplicationController
    before_action :authenticate_patient!
    before_action :set_patient, only: %i[update index]

    def index
    end

    def update
      if @patient.update(patient_params)
        flash[:success] = 'Profile Updated successfully!'
        redirect_to patients_dashboard_path
      else
        flash[:alert] = @patient.errors.full_messages.join(',')
        render :index
      end
    end

    private

    def set_patient
      @patient = current_patient
      redirect_to patients_dashboard_path if @patient.blank?
    end

    def patient_params
      params.require(:patient).permit(:name, :address, :gender, :phone)
    end
  end
end
