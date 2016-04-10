class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|

      t.integer :facility_id
      t.date :day
      t.time :speriod
      t.time :eperiod
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
