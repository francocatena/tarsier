class CreateArticlesTags < ActiveRecord::Migration
  def change
    create_table :articles_tags, id: false do |t|
      t.column :article_id, :integer, null: false
      t.column :tag_id, :integer, null: false
    end
    
    add_index :articles_tags, [:article_id, :tag_id], unique: true
  end
end
