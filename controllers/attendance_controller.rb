class AttendanceController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # enable cookies
  helpers Sinatra::Cookies

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  # runs when students attendance is updated
  post '/courses/:id' do


    foundFlag = false

    attendance_entries = Attendance.all
    attendance_entries.each do |entry|

      if entry.student_id == params[:student_id] && entry.attendance_date == params[:attendance_date]
        foundFlag = true
        puts "Match"
        puts "DB date: #{entry.attendance_date}"
        puts "Input date: #{params[:attendance_date]}"
      end
    end

    if foundFlag == false
      puts "Not Found"
      course_id = params[:id].to_i
      new_attendance = Attendance.new()

      new_attendance.attendance_date = params[:attendance_date]

      status = params[:status]
      case status
      when 'On Time'
        new_attendance.attendance_status_id = 1
      when 'Slightly late(5 minutes)'
        new_attendance.attendance_status_id = 2
      when 'Very late(over 30 minutes)'
        new_attendance.attendance_status_id = 3
      when 'Absent'
        new_attendance.attendance_status_id = 4
      when 'Authorized Absence'
        new_attendance.attendance_status_id = 5
      end

      new_attendance.student_id = params[:student_id]
      new_attendance.description = params[:description]

      new_attendance.save()
    end

    course_id = params[:id].to_i

    redirect "/courses/#{course_id}"
  end

end
