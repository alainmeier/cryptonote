class MessagesController < ApplicationController
  BLOCKED_BOTS = [
    /facebookexternalhit/,
    /Slackbot-LinkExpanding/,
    /Twitterbot/
  ].freeze

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)

    if @message.valid?
      @built_url = build_url
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
      message_to_delete = Message.find_by(id: params[:id])
      @message = message_to_delete.dup
    rescue ActiveRecord::StatementInvalid => e
      redirect_to '/404'
      return
    end

    if @message && !@message.deleted
      message_to_delete.erase_content
      message_to_delete.save
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

  def build_url
    url = request.protocol
    url += request.host_with_port
    url += request.fullpath
    url += '/' + @message.id
  end
end
