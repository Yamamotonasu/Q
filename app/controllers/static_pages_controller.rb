class StaticPagesController < ApplicationController
  def index
    @view_questions = Question.where(created_at: Time.zone.now.all_day, target: true).order("RANDOM()").limit(3)
  end

  def help
  end
end
