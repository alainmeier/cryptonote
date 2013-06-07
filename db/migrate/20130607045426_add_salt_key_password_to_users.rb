class AddSaltKeyPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :messages, :encryption_key, :string
    add_column :messages, :salt, :string
  end
end
