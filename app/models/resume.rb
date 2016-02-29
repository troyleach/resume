class Resume #< ActiveRecord::Base
  # respond_to :json

  # belongs_to :student
  # belongs_to :user

  attr_reader :id, :first_name, :last_name, :email, :phone_number, :linkedin, :twitter, :blog, :online_resume, :github, :address, :city, :state, :appt_number, :photo, :short_bio, :personal_skills, :professional_skills, :educations, :experiences, :references

  def initialize(args)
    @id                  = args["id"]
    @first_name          = args["first_name"]
    @last_name           = args["last_name"]
    @email               = args["email"]
    @phone_number        = args["phone_number"]
    @linkedin            = args["linkedin"]
    @twitter             = args["twitter"]
    @blog                = args["blog"]
    @online_resume       = args["online_resume"]
    @github              = args["github"]
    @address             = args["address"]
    @city                = args["city"]
    @state               = args["state"]
    @appt_number         = args["appt_number"]
    @photo               = args["photo"]
    @short_bio           = args["short_bio"]
    @personal_skills     = args["personal_skills"]
    @professional_skills = args["professional_skills"]
    @educations          = args["educations"]
    @experiences         = args["experiences"]
    @references          = args["references"]
  end  

  def full_name
    return "#{@first_name.capitalize} #{@last_name.capitalize}"
  end
# TODO = ADD ZIP CODE
  def full_address
    return "#{@address}, ##{@appt_number}, #{@city} #{@state.upcase}, 60611"
  end

  def self.find(id)
    student = Student.find(id)
    all_student_information = {
      'id' => student.id,
      'first_name' => student.first_name,
      'last_name' => student.last_name,
      'address' => student.address,
      'city' => student.city,
      'state' => student.state,
      'appt_number' => student.appt_number,
      'job_title' => student.job_title,
      'github' => student.github,
      'online_resume' => student.online_resume,
      'blog' => student.blog,
      'twitter' => student.twitter,
      'linkedin' => student.linkedin,
      'phone_number' => student.phone_number,
      'email' => student.email,
      'short_bio' => student.short_bio,
      'experiences' => student.experiences,
      'educations' => student.educations,
      'personal_skills' => student.personal_skills,
      'professional_skills' => student.professional_skills
    }
    Resume.new(all_student_information)
  end

# TODO => the below method will not / does not work
  def self.all
    all_students_array = Unirest.get("https://powerful-springs-3704.herokuapp.com/api/v1/students.json").body["students"]
    @students = []
    all_students_array.each do |student_hash|
      @students << Resume.new(student_hash)
    end
    @students
  end
end
