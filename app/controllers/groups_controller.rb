class GroupsController < ApplicationController

  def create
    binding.pry
    User.create(params_permit)
  end


    def params_permit
      ##今後メンバーも取得する。
      params.require(:group).permit(:name)
    end
end
