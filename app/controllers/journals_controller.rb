class JournalsController < ApplicationController

  before_action :authorise, :only => [:index]


  def new
    @journal = Journal.new
  end


  def index
    @journals = Journal.all
  end


  def create
    # require 'pry'
    # binding.pry
    @journal = Journal.new journal_params
    # raise "hell"
    if @journal.save
      redirect_to root_path
    else
      render :new
    end
  end


  def show
      @journal = Journal.find params[:id]
  end


  def edit
    @journal= Journal.find params[:id]
  end


  def update
    journal = Journal.find params[:id]
    journal.update journal_params
    redirect_to root_path
  end

  # /////////
  private
  def journal_params
    params.require(:journal).permit(:facility_id, :day, :speriod, :eperiod, :user_id)
  end


  def authorise
    redirect_to root_path unless (@current_user.present? && @current_user.admin?)
  end
end
