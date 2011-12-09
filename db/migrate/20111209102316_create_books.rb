class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :print_length
      t.string :publisher
      t.string :language
      t.string :isbn
      t.integer :category_id

      t.timestamps
    end
  end
end
