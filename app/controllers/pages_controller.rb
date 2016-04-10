class PagesController < ApplicationController
  def welcome
  end

  def create
    Journal.schedule(params[:id])
    redirect_to facilities_path

  end


end
