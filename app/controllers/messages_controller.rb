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
    # Search list of blocked bots before invalidating message
    BLOCKED_BOTS.each do |bot|
      if regex_match?(request.headers["HTTP_USER_AGENT"], bot)
        redirect_to '/404'
        return
      end
    end

    # Fixes peculiarity with UUIDs in Postgres
    begin
      @message = Message.find_by(id: params[:id])
    rescue ActiveRecord::StatementInvalid => e
      redirect_to '/404'
      return
    end

    if @message
      @message.delete
    else
      redirect_to '/404'
      return
    end
  end

  private

  def regex_match?(header, regex)
    regex =~ header
  end

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