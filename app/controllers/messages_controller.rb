class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    redirect_to root_path
  end

  def show
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
  end

  private
    def message_params
      params.require(:message).permit(:content, 
                                      :location, 
                                      :password, 
                                      :latitude, 
                                      :longitude)
    end
end