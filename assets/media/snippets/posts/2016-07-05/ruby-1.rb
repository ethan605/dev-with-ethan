class AddDeliveryFieldsToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :is_sent, :boolean
    add_column :messages, :is_delivered, :boolean
    add_column :messages, :is_read, :boolean
    add_column :messages, :is_archived, :boolean
  end
end
