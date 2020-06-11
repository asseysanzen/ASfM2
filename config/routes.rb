Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  } #deviseのコントローラー指定

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  } #deviseのコントローラー指定
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users/posts#top'

  namespace :users do

    get 'users/mypage' => 'users#mypage' #ログインユーザーのマイページ
    get 'users/follow' => 'users#follow' #ログインユーザーのフォロー一覧ページ
    get 'users/fix' => 'users#fix' #ユーザー情報修正ページ
    patch 'users/fix' => 'users#fix_update' #ユーザー情報アップデート
    put 'users/fix' => 'users#fix_update' #ユーザー情報アップデート
    resources :users, only: [:index, :show] do
      resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
    end

    get 'posts/about' => 'posts#about' #aboutページ
    get 'posts/favorite' => 'posts#favorite' #お気に入り投稿ページ
    get 'posts/follow' => 'posts#follow' #フォローユーザーの投稿ページ
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :genres, only: [:show]

    get 'purchases/thanks' => 'purchases#thanks' #ご利用ありがとうページ
    get 'purchases/buy' => 'purchases#buy' #購入履歴ページ
    get 'purchases/sell' => 'purchases#sell' #販売履歴ページ
    get 'purchases/data' => 'purchases#data' #ログインユーザーの売上ページ
    post 'purchases/create_address' => 'purchases#create_address' #購入ページで配送先登録をするため
    resources :purchases, only: [:show, :create, :update, :destroy] do
      member do
        get :input #購入情報入力ページ
        get :new_address #購入時に新しい住所を追加するための画面
        get :confirm #購入確認ページ
      end
    end

    resources :shipping_addresses, only: [:index, :edit, :update, :create, :destroy]

  end

  namespace :admins do
    get 'top' => 'purchases#top'

    resources :users, only: [:index, :show, :edit, :update]

    resources :purchases, only: [:index, :show, :update]

    resources :posts, only: [:index, :show, :edit, :update, :destroy]

    resources :genres, only: [:index, :edit, :update, :create]

    resources :payment_methods, only: [:index, :edit, :update, :create]

    resources :postages, only: [:index,:edit, :update, :create]
  end

end
