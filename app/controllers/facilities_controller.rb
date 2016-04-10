class FacilitiesController < ApplicationController
  before_action :authorise, :only => [:index]

  def new
    @facility = Facility.new
  end

  def show
    # if params[:rosterstart] = nil
    #   # params[:rosterstart] = get_next_day(Date.today, 7)
    # end
    # raise 'hell'
    if !params.key?(:rosterdate)
      tStr = Facility.where("id="+params[:id].to_s).pluck(:facilityname).flatten
      flash[:notice] = "No Roster Date Set for the facility: " + tStr[0].to_s
      redirect_to facilities_url

    else
      @facility = Facility.find params[:id]
    end
  end

  def create
    @facility = Facility.new facility_params
    if @facility.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @facility = Facility.find params[:id]
  end

  def update
    facility = Facility.find params[:id]
    facility.update facility_params
    redirect_to root_path
  end

  def setdate
    # require 'pry'
    # binding.pry
    Facility.update_all(params[:reportdate])
    redirect_to facilities_url
  end

  def index

      @facilities = Facility.all
    # @facilities = Facility.search(params[:search])

  end


  def roster
    @facility = Facility.all
  end

  private
  def facility_params
    params.require(:facility).permit(:facilityname, :companyname, :reportdate)
  end

  def authorise
    redirect_to root_path unless (@current_user.present? )
    # redirect_to root_path unless (@current_user.present? && @current_user.admin?)

  end
end

# raise 'hell'
# require 'pry'
# binding.pry
