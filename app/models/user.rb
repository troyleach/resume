class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :student
  enum survey_status: {'Personal Information' => 0,
                       'Experiences' => 1,
                       'Education' => 2,
                       'Professional skills' => 3,
                       'Personal Skills' => 4,
                       'References' => 5,
                       'User Details' => 6}

  def set_user_position(status)
    if status == 'Personal Information'
      return '/personal_informations/new'
    elsif status == 'Experiences'
      return '/experiences/new'
    elsif status == 'Education'
      return '/educations/new'
    elsif status == 'Professional skills'
      return '/professional_skills/new'
    elsif status == 'Personal Skills'
      return '/personal_skills/new'
    elsif status == 'References'
      return '/references/new'
    elsif status == 'User Details'
      return '/'
    end
  end

end
