# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :text
#  password_digest :text
#  fullname        :text
#  admin           :boolean
#  companyname     :text
#  maxhours        :integer
#  minhours        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  has_secure_password
  has_many :journals


  # need to check worker hours scheduled in current period
  def self.workerHoursSchd(dateWeekStart, userid)
    jSchd = Journal.where("user_id = :uid AND day >= :sd AND day < :ed",
                {uid: userid, sd: dateWeekStart, ed: dateWeekStart + 8.days})
    sumHours = 0
    #All time quantities are in seconds
    jSchd.each do |j|
      sumHours += (j.eperiod - j.speriod)
    end
    return sumHours
  end #def self.workerLimit


  def self.workerTimeFree(dateWeekStart, userid)
    hrSchd = workerHoursSchd(dateWeekStart, userid)
    maxH = User.where("id="+userid.to_s).pluck(:maxhours).flatten
    maxH = maxH[0].to_i
    maxH = maxH*60*60     #All time quantities are in seconds
    return (maxH - hrSchd)
  end #def self.workerOverMax


end # class
