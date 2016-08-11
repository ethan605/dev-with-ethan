class ChangeMessageIsReadField < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :is_read, :is_seen
  end
end
