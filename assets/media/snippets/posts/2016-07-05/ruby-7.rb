class ChangeMessageIsSentDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :messages, :is_sent, false
  end
end
