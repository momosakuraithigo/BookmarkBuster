Rails.application.routes.draw do
  get "contacts/new"
  get "contacts/create"
  get "pages/terms"
  get "pages/privacy"
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  # Devise routes for user authentication
  devise_for :users

  # ログインユーザーのルートパスをダッシュボードに設定
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  
  # 非ログインユーザーのルートパスをホーム画面に設定
  root to: 'home#index'

  # ダッシュボードへのルート
  get 'dashboard', to: 'dashboard#index', as: :dashboard

  # Bookmarks routes (CRUDを自動生成)
  resources :bookmarks
# プロフィール
  resource :profile, only: [:show, :edit, :update]

  # Health check (for load balancers and uptime monitors)
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Development-only routes
  if Rails.env.development?
    # Letter Opener Web for email preview
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  get 'terms', to: 'pages#terms', as: :terms
  get 'privacy', to: 'pages#privacy', as: :privacy
  resources :contacts, only: [:new, :create]
end
