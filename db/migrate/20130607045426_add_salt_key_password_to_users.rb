class AddSaltKeyPasswordToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :messages, :encryption_key, :string
    add_column :messages, :salt, :string
  end
end
