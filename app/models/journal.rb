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

  #code in this method (self.schedule) will assign workers to a facility.
  #Method iterates over the shifts in the facitliy, looks for vacant shifts and assigns workers
  def self.schedule(infacilityid)
    facilityid = infacilityid.to_s
    #get the current roster period (stored in the Facility table as I had to put it somewhere)
    schdDate = Date.parse(Facility.where("id="+facilityid).pluck(:reportdate).flatten[0].to_s)

    #Set the start date to a sunday (day 0). This app currently works on a weekly basis only
    if !schdDate.wday==0
      schdDateStart = get_prev_daynum(schdDate, 0)
    else
      schdDateStart = schdDate #already day 0
    end
    #get all shifts for the Facility
    facShifts = Shift.where("facility_id="+infacilityid)

    #loop through days sunday (0) to saturday (6)
    for dayOffset in 0..6
      schdDate = schdDateStart + dayOffset.days
      schdDay = schdDate.wday

      facShifts.each do |s|
        #Does the facility have Shifts on this date
        if schdDay = s.weekday
          #seclect all records from Journal table that match the shift
          numalloc = Journal.where("day = :sd AND speriod = :sp AND eperiod = :ep",
                      {sd: schdDate, sp: s.stime, ep: s.ftime})
          #get all workers not allocated
          availWorkers = User.where.not(:id => numalloc.pluck(:user_id));

          if numalloc.count < s.numworkers
            for i in (1.. (s.numworkers - numalloc.count))
              #allocate workers via new journals
              #check worker available
              assign_id = 0 #user_id for the worker to assign. start at 0 (ie no-one yet identified as available)
              availWorkers.each do |w|
                #Check the assignment will not cause the worker to be roster more than his/her max-hours
                #and that is not already assigned a shift somewhere else
                if ((User.workerTimeFree(schdDateStart, w.id) >= (s.ftime - s.stime))) #&& !User.hasShiftToday(schdDay, w.id))
                  assign_id = w.id
                  break
                end
              end

              if assign_id > 0
                #remove allocated worker from availWorkers list
                availWorkers = availWorkers.where.not("id = " + assign_id.to_s);
                #Create a journal i.e. assign the worker to the shift
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
          elsif numalloc.count > s.numworkers #currently more workers than shifts are assigned. Remove some
            for i in (1.. (numalloc.count - s.numworkers))
              numalloc.first.delete
            end
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
