class RemoveIsSeenFromMessage < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.remove :is_seen, :integer, null: false, default: false
    end
  end
end
