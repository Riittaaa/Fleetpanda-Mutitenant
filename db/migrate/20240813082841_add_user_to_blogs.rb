class AddUserToBlogs < ActiveRecord::Migration[7.2]
  def change
    add_reference :blogs, :user, null: false, foreign_key: true, default: 1
  end
end
