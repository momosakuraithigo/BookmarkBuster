class Tag < ApplicationRecord
    has_many :bookmark_tags, dependent: :destroy
    has_many :bookmarks, through: :bookmark_tags
  end
  