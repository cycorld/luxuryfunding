class ChaptersController < ApplicationController
  def new
    @chapter = Chapter.new(book_id: params[:book_id])
  end

  def create
    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      redirect_to book_path(@chapter.book)
    else
      render 'new'
    end
  end

  def edit
    @chapter = Chapter.find(params[:id])
  end

  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update_attributes(chapter_params)
      redirect_to book_path(@chapter.book)
    else
      render 'edit'
    end
  end

  def upload
    @chapter = Chapter.new(book_id: params[:chapter][:book_id],
                           title: params[:chapter][:file].original_filename.split('.')[0],
                           cards_attributes: Chapter.import(params[:chapter][:file])
                          )
    render 'new'
  end

  private

  def chapter_params
    params.require(:chapter).permit(:book_id, :title, cards_attributes: [:id, :question, :q_lang, :answer, :a_lang, :_destroy])
  end
end
