# frozen_string_literal: true

class ChangeForeignKeyFromUserIdToAuthorIdInPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :user_id, :author_id
    add_foreign_key :posts, :users, column: :author_id
  end
end
