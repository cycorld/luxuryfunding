class StudyController < ApplicationController
  before_action :authenticate_user!

  def index
    @boxes = current_user.boxes
    @books = Book.all
    @memories = current_user.memories
  end

  def study
    b = Box.find(params[:box_id])
    @cards = b.memories
    if @cards.empty?
      flash[:alert] = "박스가 비었습니다. 왼쪽에서 메모리를 추가해주세요!"
      redirect_to :root
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
    c = Memory.find(params[:id])
    if c.stage < 5
      c.stage += 1
      c.save!
    else
      c.touch
    end
    redirect_to :back
  end

  def unknow
    c = Memory.find(params[:id])
    c.touch
    c.stage = 1
    c.save
    redirect_to :back
  end
end
