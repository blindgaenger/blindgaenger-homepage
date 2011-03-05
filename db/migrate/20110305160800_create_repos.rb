class CreateRepos < ActiveRecord::Migration
  def self.up
    create_table :repos do |t|
      t.string :name
      t.string :description
      t.string :homepage
      t.string :url
      t.string :language
      t.integer :forks
      t.integer :watchers
      t.datetime :pushed_at
      t.boolean :fork
      t.timestamps
    end
  end
  
  def self.down
    drop_table :repos
  end
end