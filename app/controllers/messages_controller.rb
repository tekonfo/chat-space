class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
  end
  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "メッセージの作成に成功しました。"
      respond_to do |format|
        format.html { redirect_to action: :index  }
        format.json
      end
    else
      flash[:alert] = "メッセージを送信してください"
      redirect_to  action: :index
    end

  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id].to_i,user_id: current_user.id)
  end
end
