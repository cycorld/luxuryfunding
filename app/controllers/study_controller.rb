class StudyController < ApplicationController
  before_action :authenticate_user!

  def index
    @boxes = current_user.boxes
    @books = Book.includes(:chapters).includes(:cards).last(10).reverse
    @memories = current_user.memories.pluck(:card_id)
  end

  def study
    b = Box.find(params[:box_id])
    return redirect_to :root if b.user != current_user
    @cards = b.memories
    if @cards.empty?
      flash[:alert] = "The box is empty. Add cards to your box."
      return redirect_to :root
    else
      @stages_color = ['default', 'danger', 'warning', 'info', 'success', 'primary']
      @stage = params[:stage].to_i || @cards.order('updated_at DESC').last.stage
      @stages = @cards.where(stage: @stage)
      cards_hash = @cards.pluck(:stage).group_by(&:itself)
      @counts = cards_hash.map{|k,v| [k, v.length]}.to_h
      @percents = cards_hash.map{|k,v| [k, 50 * v.length.to_f / @cards.length]}.to_h
      p @counts
      if @stages.empty?
        @card = @cards.order('updated_at DESC').last
        return redirect_to "/study/#{params[:box_id]}?stage=#{@card.stage}"
      else
        @card = @stages.order('updated_at DESC').last
      end
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
    c.touch # if c.stage == 1 then not changed updated_at
    c.stage = 1
    c.save
    redirect_to :back
  end
end
