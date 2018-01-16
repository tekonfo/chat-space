class UsersController < ApplicationController

  def index
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
     format.html
     format.json { render 'index', json: @users }
    end
  end


  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    user.update(params_permit)
    redirect_to controller: :groups, action: :index
  end


  private
    def params_permit
      params.require(:user).permit(:name,:email)
    end
end
