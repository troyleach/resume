class ExperiencesController < ApplicationController

  def new
    @feedback = Feedback.new
  end

end
