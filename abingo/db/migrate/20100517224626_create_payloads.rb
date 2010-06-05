class CreatePayloads < ActiveRecord::Migration
  def self.up
    create_table :payloads do |t|
      t.string :name, :image_url
    end
  end

  def self.down
    drop_table :payloads
  end
end
