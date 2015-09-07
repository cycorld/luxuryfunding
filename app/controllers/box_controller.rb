class BoxController < ApplicationController
  before_action :authenticate_user!

  def create
    Box.create(user: current_user, title: params[:title])
    redirect_to :root
  end

  def add_chapter
    chapter = Chapter.find(params[:id])
    params[:box_id]
  end

  def add_card
    card = Card.find(params[:id])
    if Memory.where(card_id: params[:id]).take
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
