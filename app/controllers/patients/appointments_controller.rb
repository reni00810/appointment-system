module Patients
  class AppointmentsController < ApplicationController
    before_action :authenticate_patient!
    before_action :set_peginate, only: :index
    before_action :set_appointment, only: %i[show destroy edit update]

    def index
      @appointments = current_patient.appointments.page(@page).per(@per_page)
    end

    def new
      @appointment = current_patient.appointments.new
    end

    def show
    end

    def destroy
      @appointment.destroy
      flash[:success] = "Appointment Deleted"
      redirect_to patients_appointments_path
    end

    def edit
    end

    def create
      @appointment = current_patient.appointments.new(appointment_params)
      available, error = check_available_time
      if available
        if @appointment.save
          flash[:success] = "Appointment Created"
          redirect_to patients_appointment_path(@appointment.id)
        else
          flash[:notice] = @appointment.errors.full_messages.join(",")
          render :new
        end
      else
        flash[:notice] = error
        render :new
      end
    end

    def update
      available, error = check_available_time
      if available
        if @appointment.update(appointment_params)
          flash[:success] = "Appointment Updated"
          redirect_to patients_appointment_path(@appointment.id)
        else
          flash[:notice] = @appointment.errors.full_messages.join(",")
          render :edit
        end
      else
        flash[:notice] = error
        render :edit
      end
    end

    private

    def set_appointment
      @appointment = Appointment.find_by(id: params[:id])
      redirect_to patients_dashboard_path if @appointment.blank?
    end

    def appointment_params
      params.require(:appointment).permit(:doctor_id, :date, :time, :description)
    end

    def check_available_time
      date = params[:appointment][:date]
      time = params[:appointment][:time]
      doctor = Doctor.find_by(id: params[:appointment][:doctor_id])
      if doctor.present?
        unavailables = doctor.unavailables.where(date: date)
        if unavailables.present?
          unavailable_time = false
          unavailables.each do |u|
            if u.closing_time.strftime("%H:%M") > time && u.opening_time.strftime("%H:%M") < time
              unavailable_time = true
              break
            end
          end
          if unavailable_time == true
            check_regular_time(doctor, time)
          else
            return false, "Doctor not available in this time and date"
          end
        else
          check_regular_time(doctor, time)
        end
      else
        return false , "Please Select Doctor"
      end
    end

    def check_regular_time(doctor, time)
      available = doctor.operating_hour
      if available.opening_time.strftime("%H:%M") < time && available.closing_time.strftime("%H:%M") > time
        return true, "Doctor available"
      else
        return false , "Doctor Not available in this time"
      end
    end
  end
end
