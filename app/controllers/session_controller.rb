class SessionController < ApplicationController
    def new
    end

    def create
      user = User.find_by :email => params[:email]
      if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        #log them in
        redirect_to root_path
      else
        flash[:error] = "You done goofed"
        redirect_to login_path
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end

end
