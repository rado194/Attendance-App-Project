class Student

  attr_accessor :student_id, :first_name, :last_name, :course_id, :student_attendance, :attendance_date, :attendance_status_id, :description, :status, :colour_code, :course_name

  # Establishes connection to the "stores" database within PostGres
    def self.open_connection
      PG.connect(dbname: "attendance_app")
    end

    def self.find(id)
      conn = self.open_connection

      sql = "SELECT * FROM students WHERE student_id = #{id} LIMIT 1"

      response = conn.exec(sql)

      return self.hydrate(response[0])
    end

    # Requests all students data
    def self.all
      conn = self.open_connection

      sql = "SELECT * FROM students ORDER BY student_id"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate data_item
      end

      return students
    end

    def self.all_with_course
      conn = self.open_connection

      sql = "SELECT * FROM students s
            INNER JOIN courses c ON
            c.course_id = s.course_id"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate_all_plus_courses data_item
      end

      return students
    end

    def self.find id
      conn = self.open_connection

      sql = "SELECT * FROM students WHERE student_id = #{id}"

      response = conn.exec(sql)

      return self.hydrate response[0]
    end

    def self.find_firstn first_name
      conn = self.open_connection

      sql = "SELECT * FROM students s INNER JOIN courses c ON s.course_id = c.course_id
      WHERE first_name LIKE '#{first_name}%'"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate_all_plus_courses data_item
      end

      return students
    end

    def self.find_fulln first_name, last_name
      conn = self.open_connection

      sql = "SELECT * FROM students s INNER JOIN courses c ON s.course_id = c.course_id
      WHERE first_name LIKE '#{first_name}%' AND last_name LIKE '#{last_name}%'"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate_all_plus_courses data_item
      end

      return students
    end

    def save
      conn = Student.open_connection

      if (self.student_id)
        sql = "UPDATE students SET first_name='#{self.first_name}', last_name='#{self.last_name}', course_id='#{self.course_id}' WHERE student_id = '#{self.student_id}'"
      else
        sql = "INSERT INTO students (first_name ,last_name ,course_id ) VALUES ('#{self.first_name}', '#{self.last_name}', '#{self.course_id}')"
      end

      conn.exec(sql)
    end

    def self.course_attendance(id)
      conn = self.open_connection

      sql = "SELECT * FROM students WHERE course_id=#{id}"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate(data_item)
      end

      return students
    end

    def self.course_attendance_status(id)
      conn = self.open_connection

      sql = "SELECT * FROM students s
            INNER JOIN student_attendance sa ON sa.student_id = s.student_id
            WHERE course_id=#{id}"

      response = conn.exec(sql)

      students = response.map do |data_item|
        self.hydrate_a(data_item)
      end

      return students
    end

    # delete data from database
    def self.destroy(id)
      conn = self.open_connection

      sql = "DELETE FROM students WHERE student_id = #{id}"

      conn.exec(sql)
    end

    # returns attendance history of individual student
    def self.attendance_history(id)
      conn = self.open_connection

      sql = "SELECT sa.attendance_date, ast.status, sa.description, ast.colour_code FROM student_attendance sa
      INNER JOIN attendance_status ast ON sa.attendance_status_id = ast.attendance_status_id WHERE student_id='#{id}'"

      response = conn.exec(sql)

      attendance_history = response.map do |data_item|
        self.hydrate_attendance(data_item)
      end

      return attendance_history
    end

    # Convert the response from a PG::Result
    def self.hydrate(data)
      student = Student.new

      student.student_id = data['student_id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']

      return student
    end


    def self.hydrate_a data
      student = Student.new

      student.student_id = data['student_id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']
      student.student_attendance = data['student_attendance']
      student.attendance_date = data['attendance_date']
      student.attendance_status_id = data['attendance_status_id']
      student.description = data['description']

      return student
    end

    def self.hydrate_attendance(data)
      student_records = Student.new

      student_records.attendance_date = data['attendance_date']
      student_records.status = data['status']
      student_records.description = data['description']
      student_records.colour_code = data['colour_code']

      return student_records
    end

    def self.hydrate_all_plus_courses(data)
      student = Student.new

      student.student_id = data['student_id']
      student.first_name = data['first_name']
      student.last_name = data['last_name']
      student.course_id = data['course_id']
      student.course_name = data['name']

      return student
    end

end
