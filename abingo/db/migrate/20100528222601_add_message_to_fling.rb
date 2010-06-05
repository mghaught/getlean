class AddMessageToFling < ActiveRecord::Migration
  def self.up
    change_table :flings do |t|
      t.string :message
    end
  end

  def self.down
    change_table :flings do |t|
      t.remove :message
    end
  end
end