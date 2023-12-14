class AccountController < ApplicationController
    before_action :set_user_courses
    
    def index
        if !user_signed_in?
          redirect_to new_user_session_path
        else
            #for issue RAILAST206-41
          @user = User.find(params[:id])
          @courses = Course.where(id: @user.registered_courses)
        end
      end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_courses
      @user = User.find(params[:id]).registered_courses
    end

end
