class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :price
      t.integer :status, default: 1
      t.integer :frequency

      t.timestamps
    end
  end
end
