class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :location
      t.string :password
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
