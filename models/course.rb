class Course

  attr_accessor :course_id, :name, :course_type, :start_date, :end_date

  # connection to database
  def self.open_connection
    PG.connect(dbname: "attendance_app")
  end

  # get all data from courses table
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM courses ORDER BY course_id
           SELECT CONVERT (NVARCHAR, start_date,103) FROM courses"

    response = conn.exec(sql)

    # mapping new array by hydrating each response from the db
    courses = response.map do |data_item|
      self.hydrate(data_item)
    end

    return courses
  end

  # Info from 1 course
  def self.find(id)
    conn = self.open_connection

    sql = "SELECT * FROM courses where course_id = #{id}"

    response = conn.exec(sql)

    return self.hydrate response[0]
  end

  def save
    conn = Course.open_connection

    if (self.course_id)
      sql = "UPDATE courses SET name='#{self.name}', course_type='#{self.course_type}', start_date='#{self.start_date}', end_date='#{self.end_date}' WHERE course_id = '#{self.course_id}'"
    else
      sql = "INSERT INTO courses (name ,course_type ,start_date ,end_date) VALUES ('#{self.name}', '#{self.course_type}', '#{self.start_date}', '#{self.end_date}')"
    end

    conn.exec(sql)
  end

  def self.update_course id
    conn = self.open_connection

    sql = "UPDATE students SET course_id = 1 WHERE course_id = #{id}"

    conn.exec(sql)
  end

  # destroy course from table
  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM Courses WHERE course_id = #{id}"

    conn.exec(sql)
  end

  def self.hydrate(data)
    course = Course.new()

    # column names go in quotations
    course.course_id = data['course_id']
    course.name = data['name']
    course.course_type = data['course_type']
    course.start_date = data['start_date']
    course.end_date = data['end_date']

    return course
  end

end
