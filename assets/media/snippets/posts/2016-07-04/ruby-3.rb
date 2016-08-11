class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.belongs_to :from_user
      t.belongs_to :to_user

      t.timestamps
    end
  end
end
