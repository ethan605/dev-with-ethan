class ChangeMessageIsReadField < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.rename :is_read, :is_seen
    end
  end
end
