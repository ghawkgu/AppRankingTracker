class Category < ActiveRecord::Base
  attr_accessible :id, :label, :sub_categories, :parent, :level
  has_many :sub_categories, :class_name => 'Category', :primary_key => 'id', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Category', :primary_key => 'id', :foreign_key => 'parent_id'

  def to_s
    desc = ""
    desc += "#{parent.label}(#{parent.id}) -> " if parent
    desc += "#{level} - #{label}(#{id})"
  end
end
