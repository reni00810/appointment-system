class CreateOperatingHours < ActiveRecord::Migration[5.2]
  def change
    create_table :operating_hours do |t|
      t.references :doctor, foreign_key: true
      t.time :opening_time
      t.time :closing_time
      t.timestamps
    end
  end
end
