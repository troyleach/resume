class StudentsController < ApplicationController

  def index
  end

  def update
    if params["student"]
      @student = current_user.student
        if @student.update(photo_params)
          redirect_to "/",
          :flash => { :success => "Photo is saved" }
        else
          redirect_to :back, :flash => { :error => 'NOT A VALID FILE, Please attached a valid photo' }
        end
    else
      redirect_to :back, :flash => { :error => "Please attach a valid file" }
    end
  end

  def destroy
    @student = current_user.student
    @student.photo = nil
    @student.save
    redirect_to "/"
  end

  private

  def photo_params
    params.require(:student).permit(:photo)
  end

end