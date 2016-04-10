# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  facility_id :integer
#  numworkers  :integer
#  stime       :time
#  ftime       :time
#  weekday     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Shift < ActiveRecord::Base
    belongs_to :facility
end
