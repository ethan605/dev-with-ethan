class AddDeliveryToMessage < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.boolean :is_sent, null: false, default: true
      t.boolean :is_delivered, null: false, default: false
      t.boolean :is_read, :boolean, null: false, default: false
      t.boolean :is_archived, :boolean, null: false, default: false
    end
  end
end
