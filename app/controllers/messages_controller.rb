class MessagesController < ApplicationController
  before_filter :check_location, :check_password

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
  end

  def show
    @message = Message.find(params[:id])
    @message.delete
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

    def check_location
    end

    def check_password
    end
end