class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :location, :string
    add_column :users, :image, :string
    add_column :users, :description, :string
    add_column :users, :urls, :string
  end
end
