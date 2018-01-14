class MessagesController < ApplicationController
  before_action :authenticate_user!,only: :index
  before_action :get_instance
  def index
  end
  def create
    message = Message.new(message_params)
    if message.save
      flash[:notice] = "メッセージの作成に成功しました。"
      redirect_to  action: :index

    else
      flash[:alert] = "メッセージを送信してください"
      render  action: :index
    end

  end

  private

  def get_instance
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id].to_i,user_id: current_user.id)
  end
end
