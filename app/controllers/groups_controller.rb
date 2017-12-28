class GroupsController < ApplicationController

  before_action :authenticate_user!

  def index
    flash.now[:notice] = "#{params[:notice]}"
    @group = Group.new
    @groups = current_user.groups
  end

  def new
    @group = Group.new
      if params[:notice]
        @group.errors.add(:name, "エラーです")
      end
    @user = User.all
  end


  def create

    group = Group.new
    count = false
    if  group.save(:name => params_permit_group[:name])
      count = true
      params_permit_group[:user_ids].each do |id|
        Usergroup.create(:user_id => id,:group_id => group.id)
      end
    else
      count = false
    end
binding.pry
    if  count
      # この書き方はいいのか、、、
      redirect_to controller: :groups, action: :index, notice: 'グループの作成に成功しました'
    else
      redirect_to  action: :new, notice: 'エラーが起きています'
    end
  end


  def edit
    @group = Group.find(params[:id])
          if params[:notice]
        @group.errors.add(:name, "エラーです")
      end
    @user = User.all
  end

  def update
    count = 0
    group = Group.find(params[:id])
    if  group.update(:name => params_permit_group[:name])
      count = 1

      usergroups = group.usergroups
      usergroups.each do |usergroup|
        usergroup.delete
      end
      params_permit_group[:user_ids].each do |id|
        Usergroup.create(:user_id => id,:group_id => group.id)
      end
    else
      count = 0
    end

    if  count
      # この書き方はいいのか、、、
      redirect_to controller: :groups, action: :index, notice: 'グループの編集に成功しました'
    else
      redirect_to  action: :new, notice: 'エラーが起きています'
    end
  end


  private
  def params_edit_group
    params.permit(:id)
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
