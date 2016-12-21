class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.references :user, foreign_key: true
      t.string :query

      t.timestamps
    end
  end
end
