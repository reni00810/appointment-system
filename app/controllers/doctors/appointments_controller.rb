module Doctors
  class AppointmentsController < ApplicationController
    before_action :authenticate_doctor!
    before_action :set_peginate, only: :index
    before_action :set_appointment, only: %i[show confirm reject]

    def index
      @appointments = current_doctor.appointments.page(@page).per(@per_page)
    end

    def confirm
      @appointment.update(status: 'Confirm')
      flash[:success] = "Appointment Confirmed"
      redirect_to doctors_appointments_path
    end

    def reject
      @appointment.update(status: 'Reject')
      flash[:success] = "Appointment Rejected"
      redirect_to doctors_appointments_path
    end

    def show
    end

    private

    def set_appointment
      @appointment = Appointment.find_by(id: params[:id])
      redirect_to doctors_appointments_path if @appointment.blank?
    end
  end
end
