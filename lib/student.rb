require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade 
  attr_reader :id 
  
  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
        )
        SQL
    DB[:conn].execute(sql)
  end 
  
  def save
    #inserts new row into database using the attributes of the given object
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    
    #assigns the id attribute of the object once the row has been inserted into the database.
    
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end 
    
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end 
    

end
