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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
