module Doctors
  class ProfileController < ApplicationController
    before_action :authenticate_doctor!
    before_action :set_doctor, only: %i[update index]

    def index
      doctor_operating_hour = @doctor.build_operating_hour if @doctor.operating_hour.blank?
    end

    def update
      if @doctor.update(doctor_params)
        flash[:success] = 'Profile Updated successfully!'
        redirect_to doctors_dashboard_path
      else
        flash[:alert] = @doctor.errors.full_messages.join(',')
        render :index
      end
    end

    private

    def set_doctor
      @doctor = current_doctor
      redirect_to doctors_dashboard_path if @doctor.blank?
    end

    def doctor_params
      params.require(:doctor).permit(:name, :address, :gender, :phone, :qualification,
                                      operating_hour_attributes: %i[id doctor_id opening_time closing_time _destroy],
                                      unavailables_attributes: %i[id doctor_id date opening_time closing_time _destroy])
    end
  end
end
