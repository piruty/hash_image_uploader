class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :filename
      t.string :path
      t.string :hash_val
      t.string :content_type

      t.timestamps
    end
  end
end
