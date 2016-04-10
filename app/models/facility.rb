# == Schema Information
#
# Table name: facilities
#
#  id           :integer          not null, primary key
#  facilityname :text
#  companyname  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Facility < ActiveRecord::Base
  has_many :journals
  has_many :shifts

  # def self.search(search)
  #   if search
  #     find(:all, :params => ['id LIKE ?', "%#{search}%"])
  #   else
  #     find(:all)
  #   end
  # end

end
