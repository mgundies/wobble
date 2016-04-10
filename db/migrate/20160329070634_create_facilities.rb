class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.text :facilityname
      t.text :companyname
      t.timestamps null: false
    end
  end
end
