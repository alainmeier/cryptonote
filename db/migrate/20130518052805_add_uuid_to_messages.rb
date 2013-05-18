class AddUuidToMessages < ActiveRecord::Migration
  enable_extension 'uuid-ossp'
  
  def change
    drop_table :messages

    create_table :messages, id: :uuid do |t|
      t.text :content
      t.string :location
      t.string :password
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
