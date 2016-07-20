class AddUserToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :user, foreign_key: true
    add_index :articles, [:user_id, :created_at]
  end
end
