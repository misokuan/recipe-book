class AddAccessLevelToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_level, :integer, default: 0
  end
end
