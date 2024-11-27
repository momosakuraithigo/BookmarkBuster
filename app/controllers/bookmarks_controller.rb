class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy]

  def index
    @bookmarks = if params[:tag_name].present?
      current_user.bookmarks.joins(:tags).where(tags: { name: params[:tag_name] })
    else
      current_user.bookmarks
    end.page(params[:page]).per(10)

    # タグ一覧を取得（N+1問題を防ぐためincludes使用）
    @tags = current_user.bookmarks.includes(:tags).map(&:tags).flatten.uniq
  end

  def show
    # `@bookmark` は `set_bookmark` によりセットされます
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    if @bookmark.save
      update_tags 
      redirect_to bookmarks_path, notice: 'ブックマークを追加しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @bookmark.update(bookmark_params)
      update_tags
      redirect_to bookmarks_path, notice: 'ブックマークを更新しました。'
    else
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

  def update_tags
    return unless params[:tag_names].present?
    
    tag_names = params[:tag_names].split(',').map(&:strip).reject(&:empty?)
    @bookmark.tags = tag_names.map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end
end