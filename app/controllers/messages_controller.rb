class MessagesController < ApplicationController
  def index
    flash.now[:notice] = "#{params[:notice]}"

  end
end
