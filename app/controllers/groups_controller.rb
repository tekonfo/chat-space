class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    binding.pry
    group = Group.new
    group.update(params_permit)
    redirect_to controller: :messages, action: :index
  end


    def params_permit
      ##今後メンバーも取得する。
      params.require(:chat_group).permit(:name)
    end
end
