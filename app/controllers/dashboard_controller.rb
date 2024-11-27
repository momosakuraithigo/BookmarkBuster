class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bookmark_count = current_user.bookmarks.count
    @recent_bookmarks = current_user.bookmarks.order(created_at: :desc).limit(5)
    
    # 未読と既読の数を取得
    @unread_count = current_user.bookmarks.where(status: '未読').count
    @read_count = current_user.bookmarks.where(status: '既読').count
    
    @top_tags = Tag.joins(:bookmarks)
                  .where(bookmarks: { user_id: current_user.id })
                  .group('tags.name')
                  .order('count_all DESC')
                  .limit(5)
                  .count
  end
end