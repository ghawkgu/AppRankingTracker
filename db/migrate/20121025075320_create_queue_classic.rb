require 'queue_classic'

class CreateQueueClassic < ActiveRecord::Migration
  def up
    QC::Setup.create
  end

  def down
    QC::Setup.drop
  end
end
