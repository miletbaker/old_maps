Time::DATE_FORMATS[:uk_long] = lambda { |time| time.strftime("%A #{time.day.ordinalize} %B %Y, %I:%M %p") }
Time::DATE_FORMATS[:uk_long_no_time] = lambda { |time| time.strftime("%A #{time.day.ordinalize} %B %Y") }
Time::DATE_FORMATS[:uk_short] = lambda { |time| time.strftime("#{time.day.ordinalize} %b %y, %I:%M %p") }
Time::DATE_FORMATS[:uk_short_no_time] = lambda { |time| time.strftime("#{time.day.ordinalize} %b %y") }