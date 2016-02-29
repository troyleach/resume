class Student < ActiveRecord::Base
	has_many :educations #always PLURAL
	has_many :experiences
	has_many :professional_skills
	has_many :personal_skills 
  has_many :references
  # has_one :resume
  belongs_to :user

  has_attached_file :photo, 
      :styles => { medium: "200x200>", thumb: "50x50#" }
    
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment :photo, :size => { :in => 0..4.megabytes }
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  def student_full_name
    return "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end
end
