class RankingHistory < ActiveRecord::Base
  attr_accessible :update_time, :region_code, :category_id, :ranking, :application, :application_id
  belongs_to :application
end
