require 'securerandom'

class Url < ActiveRecord::Base
  attr_accessible :short_url, :url
  belongs_to :user
  validates :url, :presence => true
  before_create :shorten_url

  def shorten_url
    self.short_url = SecureRandom.hex(6)
  end

end
