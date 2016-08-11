class IndexingMessageFields < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :is_sent, :is_delivered, :is_seen
  end
end
