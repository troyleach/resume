class Api::V1::ExperiencesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def show  
		@experience = Experience.find(params[:id])
	end

  def create
    @student = current_user.student
    user_id = @student.id
    angular_experiences = params["_json"]
    angular_experiences.each do |job|
      if job["job_title"] && job["company_name"]
        @experience = Experience.create({
          :start_date => job['start_date'], 
          :end_date => job['end_date'], 
          :job_title => job['job_title'], 
          :company_name => job['company_name'], 
          :job_description => job['job_description'],
          :present => job['present'], 
          :student_id => user_id
        })
        experience_id = @experience.id
        job["details"].each do |each_detail|
          if each_detail["detail"]
            ExperienceDetail.create({:experience_id => experience_id, :detail => each_detail["detail"]})
          end
        end
      end
    end
    current_user.survey_status = 2
    current_user.save
    render "api/v1/students/show"
  end

  def update
    user_id = params[:id]
    db_experiences = Experience.where(:student_id => user_id)
    angular_experiences = params["_json"]
    need_to_delete_experiences = false
    if db_experiences.length > angular_experiences.length
      need_to_delete_experiences = true
      experiences_needing_to_be_deleted = db_experiences.length - angular_experiences.length
      experiences_to_delete_counter = angular_experiences.length
    end
    angular_experiences.each_with_index do |angular_experience, index|
      if db_experiences[index]
        db_experiences[index].update({:start_date => angular_experience['start_date'], :end_date => angular_experience['end_date'], :job_title => angular_experience['job_title'], :company_name => angular_experience['company_name'], :job_description => angular_experience['job_description'], :present => angular_experience['present']})
        db_experience_details = db_experiences[index].experience_details
        angular_experience_details = angular_experience["details"]
        angular_experience_details.delete({})
        regular_array = []
        db_experience_details.each do |activerecord_detail_object|
          regular_array << {"id" => activerecord_detail_object.id, "detail" => activerecord_detail_object.detail}
        end
        if angular_experience_details != regular_array
          if angular_experience_details.length < regular_array.length
            list_of_id = []
            angular_experience_details.each do |angular_experience_detail|
              list_of_id << angular_experience_detail["id"]
            end
            db_experience_details.each do |activerecord_detail_object|
              if !list_of_id.include?(activerecord_detail_object.id)
                activerecord_detail_object.destroy
              end
            end
          end
          counter = 0
          angular_experience_details.each do |angular_experience_detail|
            if db_experience_details[counter]
              until db_experience_details[counter].destroyed? == false
                counter =+ 1
              end
              db_experience_details[counter].update({:detail => angular_experience_detail["detail"]})
              counter += 1
            else
              ExperienceDetail.create({:detail => angular_experience_detail["detail"], :experience_id => db_experiences[index].id})
            end
          end
        end
      else
        current_experience = Experience.create({:start_date => angular_experience['start_date'], :end_date => angular_experience['end_date'], :job_title => angular_experience['job_title'], :company_name => angular_experience['company_name'], :job_description => angular_experience['job_description'], :student_id => user_id})
        experience_details = angular_experience['details']
        experience_details.delete({})
        experience_details.each do |detail|
          ExperienceDetail.create({:detail => detail['detail'], :experience_id => current_experience.id})
        end
      end
    end
    if need_to_delete_experiences
      experiences_needing_to_be_deleted.times do
        db_experiences[experiences_to_delete_counter].experience_details.each do |db_experience_detail|
          db_experience_detail.destroy
        end
        db_experiences[experiences_to_delete_counter].destroy
        experiences_to_delete_counter += 1
      end
    end
  end

  def delete
    @experience = Experience.find(params[:id])
    @student = @experience.student
    @experience.destroy
    render "students/show"
  end
      
end
