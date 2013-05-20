# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  location   :string(255)
#  password   :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
  validates :content, presence: true

  geocoded_by :location
  after_validation :geocode
end
