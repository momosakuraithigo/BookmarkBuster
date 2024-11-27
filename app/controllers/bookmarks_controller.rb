class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy toggle_favorite]

  def toggle_favorite
    @bookmark = current_user.bookmarks.find(params[:id])
  
    if @bookmark.update(favorite: !@bookmark.favorite)
      redirect_to bookmarks_path, notice: 'お気に入りを更新しました。'
    else
      redirect_to bookmarks_path, alert: 'お気に入りの更新に失敗しました。'
    end
  end

  def index
    @bookmarks = current_user.bookmarks

    # 未読/既読フィルタリング
    if params[:filter] == 'unread'
      @bookmarks = @bookmarks.where(status: '未読')
    elsif params[:filter] == 'read'
      @bookmarks = @bookmarks.where(status: '既読')
    end

    # タグでの絞り込み
    if params[:tag_name].present?
      @bookmarks = @bookmarks.joins(:tags).where(tags: { name: params[:tag_name] })
    end

    @bookmarks = @bookmarks.page(params[:page]).per(10)

    # タグ一覧を取得（N+1問題を防ぐためincludes使用）
    @tags = current_user.bookmarks.includes(:tags).map(&:tags).flatten.uniq
  end


  def show
    # `@bookmark` は `set_bookmark` によりセットされます
  end

  def new
    @bookmark = Bookmark.new
    @suggested_tags = fetch_frequent_tags
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    if @bookmark.save
      update_tags(@bookmark)
      redirect_to bookmarks_path, notice: 'ブックマークを追加しました。'
    else
      @suggested_tags = fetch_frequent_tags
      render :new
    end
  end

  def edit
    @suggested_tags = fetch_frequent_tags
  end

  def update
    if @bookmark.update(bookmark_params)
      update_tags(@bookmark)
      redirect_to bookmarks_path, notice: 'ブックマークを更新しました。'
    else
      @suggested_tags = fetch_frequent_tags
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path, notice: 'ブックマークを削除しました。'
  end

  private

  def set_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :status)
  end

  # よく使われるタグを取得するメソッド
  def fetch_frequent_tags
    Tag.joins(:bookmark_tags)
       .group("tags.id")
       .order("COUNT(bookmark_tags.id) DESC")
       .limit(10)
  end

  def update_tags(bookmark)
    return unless params[:bookmark][:tag_names].present?

    tag_names = params[:bookmark][:tag_names].split(',').map(&:strip).reject(&:empty?)
    tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    bookmark.tags = tags
  end
end
