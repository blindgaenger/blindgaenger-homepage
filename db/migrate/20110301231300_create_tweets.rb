class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :tweet_id
      t.string :screen_name
      t.string :profile_image_url
      t.string :text
      t.string :html
      t.datetime :tweeted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end