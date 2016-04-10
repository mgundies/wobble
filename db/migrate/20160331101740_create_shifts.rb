class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :facility_id
      t.integer :numworkers
      t.time :stime
      t.time :ftime
      t.integer :weekday
      t.timestamps null: false
    end
  end
end
