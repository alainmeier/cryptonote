class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @gen_password = params[:message][:gen_password]
    @message = Message.create(message_params)

    if @message.valid?
      @built_url = build_url(@gen_password)
    else
      redirect_to root_path
    end
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
      params.require(:message).permit(:content, :encryption_key, :salt)
    end

    def build_url(password)
      url = request.protocol
      url += request.host_with_port
      url += request.fullpath
      url += '/' + @message.id + '?gen_password=' + @gen_password
    end
end