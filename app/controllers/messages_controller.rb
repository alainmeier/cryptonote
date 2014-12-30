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
    # Block Facebook bot from invalidating message
    if /facebookexternalhit/.match(request.headers["HTTP_USER_AGENT"])
      redirect_to '/404'
      return
    end

    @message = Message.find_by(id: params[:id])

    if @message
      @message.delete
    else
      redirect_to '/404'
      return
    end
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