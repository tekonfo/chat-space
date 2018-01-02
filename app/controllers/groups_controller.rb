class GroupsController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.new
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @user = User.all

  end


  def create
    @group = Group.new(group_permit_params)
    if  @group.save
      # group_permit_params[:user_ids].each do |id|
      #   Usergroup.create(user_id: id,group_id: @group.id)
      # end
      flash[:notice] = "グループの作成に成功しました。"
      redirect_to  action: :index
    else
      @user = User.all
      @group.errors.clear
      @group.errors.add(:name, "グループ名を入力してください")
      render  action: :new
    end
  end


  def edit
    @group = Group.find(params[:id])
    @user = User.all
  end

  def update
    @group = Group.find(params[:id])
    if  @group.update(name: group_permit_params[:name])
      usergroups = @group.usergroups
      usergroups.each do |usergroup|
        usergroup.delete
      end
      group_permit_params[:user_ids].each do |id|
        Usergroup.create(user_id: id,group_id: @group.id)
      end
      flash[:notice] = "グループの編集に成功しました。"
      redirect_to controller: :groups, action: :index
    else
      @user = User.all
      render action: :edit
    end
  end


  private

  def group_permit_params
    params.require(:group).permit(:name, {user_ids: []})
  end


end
