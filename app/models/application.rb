class Application < ActiveRecord::Base
  attr_accessible :id, :bundle_id, :ipad, :iphone, :artist_id, :artist, :details
  belongs_to :artist
  has_many :details, :class_name => 'ApplicationDetail'
  has_many :rankings, :class_name => 'RankingHistory'

  def detail_for(region_code)
    details.where({:region_code => region_code}).first
  end
end
