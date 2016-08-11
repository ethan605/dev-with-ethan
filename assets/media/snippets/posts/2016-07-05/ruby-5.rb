class ChangeMessageIsSeenField < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :is_seen, :integer, null: false, default: 0
  end
end
