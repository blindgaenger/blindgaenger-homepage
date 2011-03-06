class CreateTumbles < ActiveRecord::Migration
  def self.up
    create_table :tumbles do |t|
      t.string :post_id
      t.string :title
      t.string :url
      t.string :body
      t.datetime :posted_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tumbles
  end
end