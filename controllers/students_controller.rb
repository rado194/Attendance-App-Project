class StudentsController < Sinatra::Base

  configure :development do
		register Sinatra::Reloader
	end

	# enable cookies
	helpers Sinatra::Cookies

  enable :sessions

	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')

	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") }

  get "/students" do
    @students = Student.all_with_course

    erb :'/students/index'
  end

  # New
  get "/students/new" do

    @courses = Course.all
    @student = Student.new

    erb :'students/new'
  end

  # Show
  get "/students/:id" do
    id = params[:id].to_i

    @attendance_record = Student.attendance_history(id)

    @ot = 0.0
    @sl = 0.0
    @vl = 0.0
    @a = 0.0
    @aa = 0.0

    @attendance_record.each do |daily_record|
      case daily_record.status
        when 'On Time'
          @ot+=1
        when 'less than 5 mins late'
          @sl+=1
        when 'more than 5 mins late'
          @vl+=1
        when 'Absent'
          @a+=1
        when 'Authorised Absence'
          @aa+=1
      end
    end

    @student = Student.find(id)
    @course = Course.find(@student.course_id)

    erb :'students/show'
  end

  # Edit
  get "/students/:id/edit" do

  end

  # Create
  post "/students/" do
    new_student = Student.new

    new_student.first_name = params[:first_name]
    new_student.last_name = params[:last_name]
    new_student.course_id = params[:course_id].to_i

    new_student.save

    redirect "/courses/#{new_student.course_id}"

  end

  # Update
  put "/students/:id" do
    id = params[:id].to_i

    student = Student.find id

    student.first_name = params[:first_name]
    student.last_name = params[:last_name]
    student.course_id = params[:course_id].to_i

    student.save

    redirect "/courses/#{course_id}"

  end


  post "/search" do
    names = params[:searchBar].split(" ")

    first_name = names[0]
    last_name = names[1]
    if names.length > 2
      names = names[0..1]
    end
    if first_name == nil
      redirect "/students"
    elsif first_name != nil
      first_name.capitalize!
    end

    if last_name != nil
      last_name.capitalize!
      @student = Student.find_fulln first_name, last_name
    elsif last_name == nil
      @student = Student.find_firstn first_name
    end
    erb :'/partials/search'
  end

  delete '/students/:id' do
    puts "Here?"
    id = params[:id].to_i

    Attendance.remove_student_attendance id
    Student.destroy id

    redirect "/students"
	end

end
