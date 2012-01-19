class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.decimal :price, null: false, precision: 15, scale: 3
      t.text :description
      t.references :brand
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
    
    add_index :articles, :code
    add_index :articles, :name
    add_index :articles, :brand_id
  end
end
