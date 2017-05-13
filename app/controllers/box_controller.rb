class BoxController < ApplicationController
  before_action :authenticate_user!

  def create
    Box.create(user: current_user, title: params[:title])
    redirect_to :root
  end

  def add_chapter
    chapter = Chapter.find(params[:id])
    return redirect_to :root if chapter.user != current_user
    total_count = chapter.cards.count
    count = 0
    chapter.cards.each do |c|
      unless Memory.where(box_id: params[:box_id], card_id: c.id).take or !current_user.boxes.where(id: params[:box_id]).take
        m = Memory.create(box_id: params[:box_id],
                      card_id: c.id,
                      question: c.question,
                      answer: c.answer,
                      q_lang: c.q_lang,
                      a_lang: c.a_lang)
        count += 1 if m
      end
    end
    flash[:alert] = "#{total_count} 개의 카드 중 #{count} 개의 카드를 추가했습니다!"
    redirect_to :root
  end

  def add_card
    card = Card.find(params[:id])
    return redirect_to :root if chapter.user != current_user
    if Memory.where(box_id: params[:box_id], card_id: params[:id]).take or !current_user.boxes.where(id: params[:box_id]).take
      flash[:alert] = "이 박스에는 이미 추가된 카드입니다."
      redirect_to :root
      return
    end
    m = Memory.create(box_id: params[:box_id],
                  card_id: params[:id],
                  question: card.question,
                  answer: card.answer,
                  q_lang: card.q_lang,
                  a_lang: card.a_lang)
    if m
      flash[:alert] = "카드 추가에 성공했습니다!"
    else
      flash[:alert] = "카드 추가에 실패했습니다 ㅠ"
    end
    redirect_to :root
  end
end
