class ProfilesController < ApplicationController
  include ProfilesHelper
  before_action :authenticate_user!, :only => [:edit]
  
  def edit
    @feedback = Feedback.new
    if current_user.survey_status == 'User Details'
      @student = current_user.student
      @experiences = @student.experiences
      @educations = @student.educations
      @professional_skills = @student.professional_skills
      @personal_skills = @student.personal_skills
      @references = @student.references
    else
      UserMailer.welcome_email(current_user).deliver_now if current_user.sign_in_count <= 1
      redirect_to current_user.set_user_position(current_user.survey_status)
    end
  end

  def show
    @students = Student.all
    @feedback = Feedback.new

    if users_name(params[:full_name])
      @student = Student.find_by_id(users_name(params[:full_name]))
      @sorted_experiences = @student.experiences.order(start_date: :desc)
      @sorted_educaitons = @student.educations.order(start_date: :desc)
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
    end
end
