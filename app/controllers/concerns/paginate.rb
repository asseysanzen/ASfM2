module Paginate
  extend ActiveSupport::Concern
  include Kaminari::PageScopeMethods

  included do
    scope :table_paginate, -> (p) { page(p[:page]).per(10) }
    scope :post_paginate, -> (p) { page(p[:page]).per(12) }
  end
end

#githubの反映確認
#githubメールアドレス反映確認