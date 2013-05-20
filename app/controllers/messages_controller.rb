class MessagesController < ApplicationController
  before_filter :check_location, :check_password

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
  end

  def show
    @latitude = request.location.latitude
    @longitude = request.location.longitude

    if @latitude && @longitude
      @message = Message.find(params[:id])
      @message.delete
    else
      redirect_to :root_path, notice: 'You are not in the right location.'
    end
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