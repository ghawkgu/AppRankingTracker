class ApplicationDetail < ActiveRecord::Base
  attr_accessible :application_id, :icon_url, :region_code, :summary, :application, :name
  belongs_to :application
end
