class PersonalSkillsController < ApplicationController

  def new
    @feedback = Feedback.new
  end

end
