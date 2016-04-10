class AddReportdateToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :reportdate, :date
  end
end
