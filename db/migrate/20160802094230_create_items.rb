class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :activity
      t.integer :condition, default: 0
      t.integer :status, default: 0
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
