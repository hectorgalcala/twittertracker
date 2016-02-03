class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :keyword
      t.string :result_type
      t.integer :limit

      t.timestamps null: false
    end
  end
end
