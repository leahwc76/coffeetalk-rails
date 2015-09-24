class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fav_cafe, :string
    add_column :users, :fav_coffee, :string
  end
end
