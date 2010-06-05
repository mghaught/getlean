class CreateFlings < ActiveRecord::Migration
  def self.up
    create_table :flings do |t|
      t.references :flinger, :payload
      t.string :target_email, :target_name
      t.timestamps
    end
    add_index :flings, :flinger_id
  end

  def self.down
    drop_table :flings
  end
end