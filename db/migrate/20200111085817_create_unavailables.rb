class CreateUnavailables < ActiveRecord::Migration[5.2]
  def change
    create_table :unavailables do |t|
      t.references :doctor, foreign_key: true
      t.date :date
      t.time :opening_time
      t.time :closing_time 
      t.timestamps
    end
  end
end
