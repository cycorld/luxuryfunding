class BooksController < ApplicationController
  def index
    @books = Book.all.includes(:chapters).includes(:cards)
  end

  def show
    @book = Book.find(params[:id])
    @memories = current_user.memories.pluck(:card_id)
  end
end
