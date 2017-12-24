class GroupsController < ApplicationController

  def new
    @group = Group.new
      if params[:notice]
        @group.errors.add(:name, "エラーです")
      end
    @user = User.all
  end


  def create


    count = 0
    if  group = Group.create(:name => params_permit_group[:name])
      count = 1
      params_permit_group[:user_ids].each do |id|
        Usergroup.create(:user_id => id,:group_id => group.id)
      end
    else
      count = 0
    end



    if  count
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
