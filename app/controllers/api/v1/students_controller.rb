class Api::V1::StudentsController < ApplicationController
    skip_before_filter :verify_authenticity_token

  def index
  	@students = Student.all
  end

  def show  
		@student = Student.find(params[:id])
    	# @educations = @student.educations
    	# @experiences = @student.experiences
    	# @skills = @student.skills
  end

  def create
    user_id = current_user.id
    @student = Student.create({
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :job_title => params[:job_title],
      :email => params[:email],
      :phone_number => params[:phone_number],
      :github => params[:github],
      :blog => params[:blog],
      :twitter => params[:twitter],
      :linkedin => params[:linkedin],
      :address => params[:address],
      :appt_number => params[:appt_number],
      :city => params[:city],
      :state => params[:state],
      :short_bio => params[:short_bio],
      :user_id => user_id
    })

    current_user.survey_status = 1
    current_user.save

    redirect_to "#{api_v1_student_path(@student.id)}.json"
  end

  def update
    new_personal_info = params["_json"][0]
    p new_personal_info
    @student = Student.find(params[:id])
    p @student
	  @student.update({
      :first_name => new_personal_info['first_name'], 
      :last_name => new_personal_info['last_name'],
      :job_title => new_personal_info['job_title'],
      :email => new_personal_info['email'], 
      :phone_number => new_personal_info['phone_number'], 
      :github => new_personal_info['github'], 
      :blog => new_personal_info['blog'], 
      :twitter => new_personal_info['twitter'], 
      :linkedin => new_personal_info['linkedin'],
      :address => new_personal_info['address'],
      :appt_number => new_personal_info['appt_number'],
      :city => new_personal_info['city'],
      :state => new_personal_info['state'],
      :online_resume => new_personal_info['online_resume'], 
      :photo => new_personal_info['photo'], 
      :short_bio => new_personal_info['short_bio']
    })
	  render 'show'
  end
	
end
