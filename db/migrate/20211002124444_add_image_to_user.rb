class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :stron
  end
end
