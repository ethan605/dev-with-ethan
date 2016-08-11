class IndexingMessageFields < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.index :is_sent, :is_delivered, :is_seen
    end
  end
end
