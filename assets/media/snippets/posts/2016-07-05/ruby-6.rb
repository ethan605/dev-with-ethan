class ChangeMessageIsSeenField < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.change :is_seen, :integer, null: false, default: 0
    end
  end
end
