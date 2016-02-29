class ProfessionalSkillsController < ApplicationController

  def new
    @feedback = Feedback.new
  end

end
