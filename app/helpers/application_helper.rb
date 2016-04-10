module ApplicationHelper

  # Lookup string value for day of week based on integer value stored in DB
  def get_day(i)
     return case i
      when 1
        "Mon"
      when 2
        "Tue"
      when 3
        "Wed"
      when 4
        "Thu"
      when 5
        "Fri"
      when 6
        "Sat"
      when 7
        "Sun"
      end
  end

end


def get_next_day(date, day_of_week)
  date + ((day_of_week - date.wday) % 7)
end

#Finds date value of the day_of_week preceeding the supplied date
#example sunday = 0, date is 28-April-2016: get_prev_daynum(2016-04-28, 0) returns 2016-04-24
def get_prev_daynum(date, day_of_week)
  date + ((day_of_week - date.wday) % 7 - 7)
end
