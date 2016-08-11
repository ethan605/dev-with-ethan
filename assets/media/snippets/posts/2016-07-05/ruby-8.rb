class ChangeMessageIsSentNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :messages, :is_sent, true
  end
end
