class MessagesController < ApplicationController
  before_filter :check_location, :check_password

  def new
    @message = Message.new
  end

  def create
    @gen_password = params[:message][:gen_password]

    @message = Message.create(message_params)

    @built_url = request.protocol + request.host_with_port + request.fullpath + '/' + @message.id + '?gen_password=' + @gen_password
  end

  def show
    @latitude = request.location.latitude
    @longitude = request.location.longitude

    if @latitude && @longitude
      @message = Message.find(params[:id])
      #@message.delete
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
                                      :longitude,
                                      :encryption_key,
                                      :salt)
    end

    def check_location
    end

    def check_password
    end
end