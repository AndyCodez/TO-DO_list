class AddUserIdToRequesters < ActiveRecord::Migration[5.0]
  def change
    add_column :requesters, :user_id, :integer
  end
end
