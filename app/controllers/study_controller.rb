class StudyController < ApplicationController
  def index
    @boxes = Box.all
  end

  def study
    b = Box.find(params[:box_id])
    @cards = b.cards
    if @cards.empty?
      render text: "empty cards..."
    else
      @stage = params[:stage].to_i || @cards.order('updated_at DESC').last.stage
      @stageds = @cards.where(stage: @stage)
      if @stageds.empty?
        @card = @cards.order('updated_at DESC').last
        @stage = @card.stage
      else
        @card = @stageds.order('updated_at DESC').first
      end
    end
  end
end
