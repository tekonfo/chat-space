class GroupsController < ApplicationController

  def new
    @group = Group.new
      if params[:notice]
        @group.errors.add(:name, "エラーです")
      end
    @user = User.all
  end


  def create
    # binding.pry
    if  Group.create(params_permit_group).valid?
      # この書き方はいいのか、、、
      redirect_to controller: :messages, action: :index, notice: 'グループの作成に成功しました'
    else
      redirect_to  action: :new, notice: 'エラーが起きています'
    end
  end

  def params_permit_group
    params.require(:chat_group).permit(:name, {user_ids: []})


  end

  # def params_permit_notice
  #   if params.require(:notice).present?
  #     params.require(:notice).permit(:name)
  #   end
  # end

  # def params_permit_user
  #   params.require(:check_box).permit(:user_ids)
  # end


end
