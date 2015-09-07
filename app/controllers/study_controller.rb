class StudyController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @boxes = Box.all
    @books = Book.all
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
        redirect_to "/study/#{params[:box_id]}?stage=#{@card.stage}"
      end
      @card = @stageds.order('updated_at DESC').last
    end
  end

  def know
    c = Card.find(params[:id])
    if c.stage < 5
      c.stage += 1
      c.save!
    else
      c.touch
    end
    redirect_to :back
  end

  def unknow
    c = Card.find(params[:id])
    c.touch
    c.stage = 1
    c.save
    redirect_to :back
  end
end
