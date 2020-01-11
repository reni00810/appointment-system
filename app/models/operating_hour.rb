class OperatingHour < ApplicationRecord
  belongs_to :doctor

  validates :opening_time, :closing_time, presence: true
end
