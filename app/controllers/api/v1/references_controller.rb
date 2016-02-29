class Api::V1::ReferencesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def show
		@reference = Reference.find(params[:id])
	end
	
	def create
		@student = current_user.student
		student_id = @student.id
		if params["showReferences"]
			@student.show_references = true
			@student.save
		end
		params["references"].each do |reference|
		  if reference["firstName"] && reference["lastName"]
		    Reference.create({:student_id => student_id, :first_name => reference["firstName"], :last_name => reference["lastName"], :email => reference["email"], :phone_number => reference["phoneNumber"], :company_name => reference["companyName"]})
		  end
		end

		current_user.survey_status = 6
		current_user.save

		redirect_to "#{api_v1_student_path(student_id)}.json"
	end

	def update
		@student = current_user.student
		existing_references = current_user.student.references
		references_to_delete = params["destroyReferences"]
		if params["showReferences"] != @student.show_references
			@student.show_references = params["showReferences"]
			@student.save
		end

		params["references"].each do |reference|
			if reference["id"] && reference["changed"]
				data_base_reference = existing_references.find(reference["id"])
				update_reference(data_base_reference, reference)
			end

			if !reference["id"]
				add_reference(reference)
			end

		end
		if !references_to_delete.nil?
			references_to_delete.each do |reference|
				reference_to_delete = existing_references.find(reference["id"])
				delete_from_group(reference_to_delete)
			end
		end

		render "/api/v1/students/show"
	end

	# def delete
	# 	@references = Reference.find(params[:id])
	# 	@student = @references.student
	# 	@references.destroy
	# 	render "students/show"
	# end

	private

	def add_reference(object_to_add)
	  reference = Reference.new({
	    :first_name => object_to_add["first_name"],
	    :last_name => object_to_add["last_name"],
	    :company_name => object_to_add["company_name"],
	    :phone_number => object_to_add["phone_number"],
	    :email => object_to_add["email"],
	    :student_id => @student.id
	  })
	  reference.save
	end

	def delete_from_group(object_to_delete)
	  object_to_delete.destroy
	end

	def update_reference(old_reference, new_reference)
	  old_reference.update({
	    :first_name => new_reference["first_name"],
	    :last_name => new_reference["last_name"],
	    :company_name => new_reference["company_name"],
	    :phone_number => new_reference["phone_number"],
	    :email => new_reference["email"]
	    })
	end

end
