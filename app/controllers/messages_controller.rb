class MessagesController < ApplicationController
  def index
    flash.now[:notice] = "#{params[:notice]}"
    @group = Group.new
  end
end
