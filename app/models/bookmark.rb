class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :bookmark_tags, dependent: :destroy
  has_many :tags, through: :bookmark_tags
  scope :favorites, -> { where(favorite: true) }
  
  # タグ名の配列を受け取ってタグを更新するメソッド
  def save_tags(tag_names)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tag_names
    new_tags = tag_names - current_tags

    # 古いタグを削除
    old_tags.each do |old|
      self.tags.delete(Tag.find_by(name: old))
    end

    # 新しいタグを追加
    new_tags.each do |new|
      new_bookmark_tag = Tag.find_or_create_by(name: new)
      self.tags << new_bookmark_tag
    end
  end
end
