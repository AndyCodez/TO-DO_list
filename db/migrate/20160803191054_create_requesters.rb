class CreateRequesters < ActiveRecord::Migration[5.0]
  def change
    create_table :requesters do |t|
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
