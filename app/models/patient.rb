class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   validates :name, :phone, presence: true
   validates :phone, length: {maximum: 15}

   has_many :appointments, dependent: :destroy
end
