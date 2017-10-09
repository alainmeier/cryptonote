# == Schema Information
#
# Table name: messages
#
#  id             :uuid             not null, primary key
#  content        :text
#  location       :string(255)
#  password       :string(255)
#  latitude       :float
#  longitude      :float
#  created_at     :datetime
#  updated_at     :datetime
#  encryption_key :string(255)
#  salt           :string(255)
#  message_type   :string(255)      default("text")
#

class Message < ActiveRecord::Base
  validates :content, presence: true

  attr_accessor :gen_password, :pre_encryption

  after_initialize :generate_uuid

  def erase_content
    to_delete = %w(latitude longitude location
                   password salt encryption_key)

    to_delete.each do |field|
      self.send("#{field}=".to_sym, nil)
    end

    self.content = "garbage"
    self.deleted = true
    self
  end

  protected
  def generate_uuid
    self.id ||= SecureRandom.uuid
  end

end
