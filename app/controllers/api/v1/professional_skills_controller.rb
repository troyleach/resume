class Api::V1::ProfessionalSkillsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @student = current_user.student
    student_id = @student.id
    params["_json"].each do |skill|
      if skill["skillKey"]
      	ProfessionalSkill.create({:student_id => student_id, :skill_name => skill["skillKey"]})
      end
    end

    current_user.survey_status = 4
    current_user.save

    redirect_to "#{api_v1_students_path(student_id)}.json"
  end

  def update
    student_id = params[:id]
    student = Student.find(student_id)
    json_p_s = params["_json"]
    db_p_s = student.professional_skills
    list_of_json_ids = []
    json_p_s.each do |json_professional_skill|
      if json_professional_skill["id"]
        list_of_json_ids << json_professional_skill["id"]
        db_p_s.each do |db_professional_skill|
          if db_professional_skill.id == json_professional_skill["id"] && json_professional_skill["skill_name"] != db_professional_skill["skill_name"] #handles a change in existing skill
            db_professional_skill.update({
              :skill_name => json_professional_skill["skill_name"]
            })
          end
        end
      elsif !json_professional_skill["id"] #handles a creation of a new skill. Any new skill will not have an ID. Hence the if statement can catch if it is a new skill by checking if it has an id.
        ProfessionalSkill.create({
          :skill_name => json_professional_skill["skill_name"],
          :student_id => student_id
          })
      end
    end
    db_p_s.each do |db_professional_skill|
      if !list_of_json_ids.include?(db_professional_skill.id)
        db_professional_skill.destroy
      end
    end
  end

end