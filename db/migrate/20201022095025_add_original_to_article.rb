class AddOriginalToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :original, :text
  end
end
