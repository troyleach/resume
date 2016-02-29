class Api::V1::ExperienceDetailsController < ApplicationController

	def index
		@details = ExperienceDetail.all
	end


	def show
		@experience_detail = ExperienceDetail.find(params[:id])
	end

	def create
		@experience_detail = ExperienceDetail.create({:experience_id => params[:experience_id], :detail => params[:detail]})
		redirect_to "#{api_v1_students_path}.json"
	end

	def update
		@experience_detail = ExperienceDetail.find(params[:id])
		@experience_detail.update({:detail => params[:experience_detail]})
		@student = @experience_detail.experience.student
		render "students/show"
	end

	def delete
		@experience_detail = ExperienceDetail.find(params[:id])
		@student = @experience_detail.experience.student
		@experience_detail.destroy
			render "students/show"
	end
	


end
