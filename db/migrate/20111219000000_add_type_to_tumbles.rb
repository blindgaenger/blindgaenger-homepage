class AddTypeToTumbles < ActiveRecord::Migration
  def self.up
    add_column :tumbles, :body_type, :string
  end

  def self.down
    remove_column :tumbles, :body_type
  end
end