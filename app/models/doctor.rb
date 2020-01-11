class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments, dependent: :destroy
  has_one :operating_hour, dependent: :destroy
  has_many :unavailables, dependent: :destroy

  validates :name, :phone, :qualification, presence: true
  validates :phone, length: {maximum: 15}

  accepts_nested_attributes_for(:operating_hour, reject_if: :all_blank, allow_destroy: true)
  accepts_nested_attributes_for(:unavailables, reject_if: :all_blank, allow_destroy: true)

end
