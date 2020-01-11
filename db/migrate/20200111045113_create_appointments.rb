class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :doctor, foreign_key: true
      t.references :patient, foreign_key: true
      t.date :date
      t.time :time
      t.text :description
      t.string :status, limit: 50

      t.timestamps
    end
  end
end
