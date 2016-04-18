class ShiftsController < ApplicationController
  before_action :authorise, :except => [:show, :index]

  def new
    @shift = Shift.new
  end

  def create
    # require 'pry'
    # binding.pry
    @shift = Shift.new shift_params
    # raise "hell"
    @shift.save
    @shifts = Shift.all
    render :new

  end

  def edit
    @shift= Shift.find params[:id]
  end

  def update
    shift = Shift.find params[:id]
    shift.update shift_params
    redirect_to root_path
  end

  def show
      @shift = Shift.find params[:id]
  end

  def index
    @shifts = Shift.all
  end

  private
  def shift_params
    params.require(:shift).permit(:facility_id, :shiftnumber, :numworkers, :stime, :ftime, :weekday)
  end

  def authorise
    redirect_to root_path unless (@current_user.present? && @current_user.admin?)
  end
end
