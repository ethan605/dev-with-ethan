class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.references :from_user, foreign_key: true
      t.references :to_user, foreign_key: true

      t.timestamps
    end
  end
end
