# == Schema Information
#
# Table name: journals
#
#  id          :integer          not null, primary key
#  facility_id :integer
#  day         :date
#  speriod     :time
#  eperiod     :time
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Journal < ActiveRecord::Base
  belongs_to :user
  belongs_to :facility

  #code in self.schedule will assign workers to a facility
  #iterates over the shifts in the facitliy, looks for vacant shifts and assigns workers
  def self.schedule(infacilityid)
    facilityid = infacilityid.to_s
    schdDate = Date.parse(Facility.where("id="+facilityid).pluck(:reportdate).flatten[0].to_s)
    if !schdDate.wday==0
      schdDateStart = get_prev_daynum(schdDate, 0)
    else
      schdDateStart = schdDate
    end
    facShifts = Shift.where("facility_id="+infacilityid)
    for dayOffset in 0..6
      schdDate = schdDateStart + dayOffset.days
      schdDay = schdDate.wday
      facShifts.each do |s|
        #Does the facility have Shifts on this date
        if schdDay = s.weekday
          #see if there are enough Journals for the shift
          numalloc = Journal.where("day = :sd AND speriod = :sp AND eperiod = :ep",
                      {sd: schdDate, sp: s.stime, ep: s.ftime})
          #get all workers not allocated
          availWorkers = User.where.not(:id => numalloc.pluck(:user_id));
          if numalloc.count < s.numworkers
            for i in (1.. (s.numworkers - numalloc.count))
              #allocate workers via new journals
              #check worker available
              assign_id = 0
              availWorkers.each do |w|
                if (User.workerTimeFree(schdDateStart, w.id) >= (s.ftime - s.stime))
                  assign_id = w.id
                  break
                end
              end
              #remove allocated worker from availWorkers...
              availWorkers = availWorkers.where.not("id = " + assign_id.to_s);
              if assign_id > 0
                Journal.new do |j|
                  j.facility_id = infacilityid
                  j.day = schdDate
                  j.speriod = s.stime
                  j.eperiod = s.ftime
                  j.user_id = assign_id
                  j.save
                end
              end
            end # for i in (1.. (s.numworkers - numalloc.count)
          end # if numalloc.count < s.numworkers
        end #if schdDate.wday = s.weekday
      end #f.shifts.each do |s|
    end
  end #def self.schedule

end #Class Journal



    # create_table "users", force: :cascade do |t|
    #   t.text     "email"
    #   t.text     "password_digest"
    #   t.text     "fullname"
    #   t.boolean  "admin"
    #   t.text     "companyname"
    #   t.integer  "maxhours"
    #   t.integer  "minhours"
    #   t.datetime "created_at",      null: false
    #   t.datetime "updated_at",      null: false
    # end

# create_table "facilities", force: :cascade do |t|
#   t.text     "facilityname"
#   t.text     "companyname"
#   t.datetime "created_at",   null: false
#   t.datetime "updated_at",   null: false
#   t.date     "reportdate"
# end
#
#
# create_table "shifts", force: :cascade do |t|
#   t.integer  "facility_id"
#   t.integer  "numworkers"
#   t.time     "stime"
#   t.time     "ftime"
#   t.integer  "weekday"
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
# end
