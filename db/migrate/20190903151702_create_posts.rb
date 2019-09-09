class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :colour
      t.string :gender
      t.string :age
      t.integer :user_id
    end
  end
end
