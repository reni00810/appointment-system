class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validate :date, :time
  
  after_create :change_status

  def change_status
    update(status: 'Request')
  end
end
