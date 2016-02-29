class Api::V1::PersonalSkillsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @student = current_user.student
	student_id = @student.id
	params["_json"].each do |skill|
	  if skill["skillKey"]
		PersonalSkill.create({:skill_name => skill["skillKey"], :student_id => student_id})
	  end
    end

    current_user.survey_status = 5
    current_user.save

    redirect_to "#{api_v1_students_path(student_id)}.json"
  end

  def update
    student_id = params[:id]
    student = Student.find(student_id)
    json_p_s = params["_json"]
    db_p_s = student.personal_skills
    list_of_json_ids = []
    json_p_s.each do |json_personal_skill|
      if json_personal_skill["id"]
        list_of_json_ids << json_personal_skill["id"]
        db_p_s.each do |db_personal_skill|
          if db_personal_skill.id == json_personal_skill["id"] && json_personal_skill["skill_name"] != db_personal_skill["skill_name"] #handles a change in existing skill
            db_personal_skill.update({
              :skill_name => json_personal_skill["skill_name"]
            })
          end
        end
      elsif !json_personal_skill["id"] #handles a creation of a new skill. Any new skill will not have an ID. Hence the if statement can catch if it is a new skill by checking if it has an id.
        PersonalSkill.create({
          :skill_name => json_personal_skill["skill_name"],
          :student_id => student_id
          })
      end
    end
    db_p_s.each do |db_personal_skill|
      if !list_of_json_ids.include?(db_personal_skill.id)
        db_personal_skill.destroy
      end
    end
  end

end
