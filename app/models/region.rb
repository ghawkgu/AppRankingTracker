class Region < ActiveRecord::Base
  attr_accessible :code, :name_en, :name_ja, :enabled
end
