class Api::V1::EducationsController < ApplicationController
	skip_before_filter :verify_authenticity_token

  def show
    @education = Education.find(params[:id])
  end

  def create
    @student = current_user.student
    student_id = @student.id
    json_educations = params["_json"]
    json_educations.each do |education|
      if education["universityName"] && education["degree"]
        @education = Education.create({
          :start_date => education["startDate"],
          :end_date => education["endDate"],
          :degree => education["degree"],
          :university_name => education["universityName"],
          :present => education['present'],
          :student_id => student_id
        })
        education_id = @education.id
        # education["highlights"].each do |highlight|
        #   if highlight["highlight"]
        #     EducationDetail.create({:education_id => education_id, :detail => highlight["highlight"]})
        #   end
        # end
      end
    end
		current_user.survey_status = 3
		current_user.save
    redirect_to "#{api_v1_students_path}.json"
  end

  def update
    @student = Student.find(params[:id])
    current_user = @student
    db_educations = current_user.educations

    json_educations = params["educations"]
    educations_to_delete = params['destroyEducations']
    details_to_delete = params['destroyDetail']

    if !educations_to_delete.nil?
      educations_to_delete.each do |education|
        education['details'].pop
        if !education['details'].empty?
          education['details'].each do |detail|
            detail_to_delete = db_educations.find(education['id']).education_details.find(detail['id'])
            delete_from_group(detail_to_delete)
          end
        end
        education_to_delete = db_educations.find(education['id'])
        delete_from_group(education_to_delete)
      end
    end

    json_educations.each do |education|
      if !education['id']
        add_educaiton(education)
      end

      if education['id'] && education['changed']
        db_education = db_educations.find(education['id'])
        update_education(db_education, education)
      end


      update_details(education['id'], education['details'])

      if !education['id'].nil? && db_educations.find(education['id']).education_details.size != education['details'].size
        db_educations = current_user.educations
        education['details'].each { |detail|
          db_educations.find(education['id']).education_details.select { |bd_detail| delete_from_group(bd_detail) if bd_detail['id'] != detail['id'] }
        }
      end
    end

		render "/api/v1/students/show"
	end

	def delete
		@education = Education.find(params[:id])
		@student = @education.student
		@education.destroy
		render "students/show"
	end

  
  private

  def add_educaiton(object_to_add)
    education = Education.new({
      :degree => object_to_add["degree"],
      :university_name => object_to_add["university_name"],
      :start_date => object_to_add["start_date"],
      :end_date => object_to_add["end_date"],
      :student_id => @student.id
    })
    education.save
    update_details(education['id'], object_to_add['details'])
  end

  def delete_from_group(object_to_delete)
    object_to_delete.destroy
  end

  def update_education(old_education, new_education)
    old_education.update({
      :degree => new_education["degree"],
      :university_name => new_education["university_name"],
      :start_date => new_education["start_date"],
      :end_date => new_education["end_date"],
      })
  end

  def update_details(education_id, details)
    if !details.nil? && !education_id.nil?
      details.pop
      details.each do |detail|
        if @student.educations.find(education_id).education_details.find_by_id(detail['id'])
          detail_object = @student.educations.find(education_id).education_details.find_by_id(detail['id'])
          detail_object['detail'] = detail['detail']
          detail_object.save
        else
          EducationDetail.create({:education_id => education_id, :detail => detail['detail']})    
        end
      end
    end
  end

end
