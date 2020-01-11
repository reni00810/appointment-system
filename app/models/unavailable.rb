class Unavailable < ApplicationRecord
  belongs_to :doctor
  validates :date, :opening_time, :closing_time, presence: true
end
