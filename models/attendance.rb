class Attendance

  attr_accessor :attendance_id, :attendance_date, :attendance_status_id, :student_id, :description

  # connection to database
  def self.open_connection
    PG.connect(dbname: "attendance_app")
  end

  # get all data from attendance table
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM student_attendance ORDER BY student_attendance_id"

    response = conn.exec(sql)

    # mapping new array by hydrating each response from the db
    attendance = response.map do |data_item|
      self.hydrate(data_item)
    end

    return attendance
  end

  def self.find(id)
    conn = self.open_connection

    sql = "SELECT * FROM student_attendance where student_attendance_id = #{id}"

    response = conn.exec(sql)

    return self.hydrate response[0]
  end

  def save
    conn = Attendance.open_connection

    sql = "INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('#{self.attendance_date}', '#{self.student_id}', '#{self.attendance_status_id}', '#{self.description}')"

    conn.exec(sql)
  end

  def self.hydrate(data)
    attendance = Attendance.new()

    # column names go in quotations
    attendance.attendance_id = data['student_attendance_id']
    attendance.attendance_date = data['attendance_date']
    attendance.attendance_status_id = data['attendance_status_id']
    attendance.student_id = data['student_id']
    attendance.description = data['description']

    return attendance
  end

  def self.remove_student_attendance(id)
    puts "Were now going to remove attendance data!"

    conn = self.open_connection

    sql = "DELETE FROM student_attendance WHERE student_id = #{id}"

    conn.exec(sql)
  end

end
