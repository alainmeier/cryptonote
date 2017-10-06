class AddSqliteSupport < ActiveRecord::Migration[5.0]
  def change
    drop_table :messages
    @adapter_type = connection.adapter_name.downcase.to_sym
    case @adapter_type
    when :sqlite
      create_table :messages, id: :string do |t|
        t.text :content
        t.string :location
        t.string :password
        t.float :latitude
        t.float :longitude
        t.timestamps
        t.string :encryption_key
        t.string :salt
        t.boolean :deleted, default: false
      end
    when :postgresql
      enable_extension 'plpgsql'
      enable_extension 'uuid-ossp'
      create_table :messages, id: :uuid do |t|
        t.text :content
        t.string :location
        t.string :password
        t.float :latitude
        t.float :longitude
        t.timestamps
        t.string :encryption_key
        t.string :salt
        t.boolean :deleted, default: false
      end
    else
      raise NotImplementedError, "Unknown adapter type '#{@adapter_type}'"
    end
  end
end
