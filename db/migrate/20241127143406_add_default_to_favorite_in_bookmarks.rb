class AddDefaultToFavoriteInBookmarks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :bookmarks, :favorite, from: nil, to: false
  end
end
