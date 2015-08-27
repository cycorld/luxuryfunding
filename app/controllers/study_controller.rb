class StudyController < ApplicationController
  def index
    @boxes = Box.all
  end

  def study
    b = Box.find(params[:box_id])
    @cards = b.cards
    @card = @cards.where(stage: params[:stage] || 1).order('updated_at DESC').first
  end
end
