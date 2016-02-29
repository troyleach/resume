class Api::V1::EducationDetailsController < ApplicationController

	def show
		@detail = EducationDetail.find(params[:id])
	end

	def create
		@education_detail = EducationDetail.create({:detail => params[:detail], :education_id => params[:education_id]})
		@student = @education_detail.education.student
		render "students/show"
	end

	def update
		@education_detail = EducationDetail.find(params[:id])
		@education_detail.update({:detail => params[:detail]})
		@student = @education_detail.education.student
		render "students/show"
	end

	def delete
		@education_detail = EducationDetail.find(params[:id])
		@student = @education_detail.education.student
		@education_detail.destroy
		render "students/show"
	end
	
end
