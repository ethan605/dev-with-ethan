class RemoveIsSeenFromMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :is_seen, :integer, null: false, default: false
  end
end
