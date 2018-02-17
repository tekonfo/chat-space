class UsersController < ApplicationController

  def index
    user_id = []
    if params[:user_ids]
      params[:user_ids].each do |users_id|
        user_id << users_id.to_i
      end
    end
    @users = User.search(params[:keyword],user_id)
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
