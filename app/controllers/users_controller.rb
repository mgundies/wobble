class UsersController < ApplicationController
  before_action :authorise, :only => [:index]

  def new
    @user = User.new
  end

  def create
    # require 'pry'
    # binding.pry

    @user = User.new user_params

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user= @current_user
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to root_path
  end

  def show
  end

  def index
    authorise
    @users = User.all
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :fullname, :companyname, :maxhours, :minhours)
  end

  def authorise
    redirect_to root_path unless (@current_user.present? && @current_user.admin?)

  end

end
