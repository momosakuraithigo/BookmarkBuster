class AddFavoriteToBookmarks < ActiveRecord::Migration[8.0]
  def change
    add_column :bookmarks, :favorite, :boolean
  end
end
