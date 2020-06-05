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
    get 'users/data' => 'users#data' #ログインユーザーの売上ページ
    get 'users/follow' => 'users#follow' #ログインユーザーのフォロー一覧ページ
    get 'users/fix' => 'users#fix' #ユーザー情報修正ページ
    patch 'users/fix' => 'users#fix_update' #ユーザー情報アップデート
    put 'users/fix' => 'users#fix_update' #ユーザー情報アップデート
    resources :users, only: [:index, :show]

    get 'posts/about' => 'posts#about' #aboutページ
    get 'posts/favorite' => 'posts#favotite' #お気に入り投稿ページ
    get 'posts/follow' => 'posts#follow' #フォローユーザーの投稿ページ
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :genres, only: [:show]

    get 'purchases/input' => 'purchases#input' #購入情報入力ページ
    get 'purchases/confirm' => 'purchases#confirm' #購入確認ページ
    get 'purchases/thanks' => 'purchases#thanks' #ご利用ありがとうページ
    get 'purchases/buy' => 'purchases#buy' #購入履歴ページ
    get 'purchases/sell' => 'purchases#sell' #販売履歴ページ
    resources :purchases, only: [:show, :create]

    resources :shipping_addresses, only: [:index, :edit, :update, :create, :destroy]

  end

  namespace :admins do
    get 'top' => 'purchases#top'

    resources :users, only: [:index, :show, :edit, :update]

    get 'purchases/data' => 'purchases#data' #アプリの売上ページ
    resources :purchases, only: [:index, :show, :update]

    resources :posts, only: [:index, :show, :edit, :update]

    resources :genres, only: [:index, :edit, :update, :create]

    resources :payment_methods, only: [:index, :edit, :update, :create]

    resources :postages, only: [:index,:edit, :update, :create]
  end

end
