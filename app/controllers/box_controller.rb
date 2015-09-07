class BoxController < ApplicationController
  before_action :authenticate_user!
  def create
    Box.create(user: current_user, title: params[:title])
    redirect_to :root
  end
end
