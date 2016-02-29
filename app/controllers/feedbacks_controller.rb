class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    student_id = current_user.student.id
    @feedback = Feedback.new(params[:feedback])
    @feedback.request = request
    if @feedback.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to current_user.set_user_position(current_user.survey_status)
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end