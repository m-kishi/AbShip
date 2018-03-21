source 'https://rubygems.org'

# --------------------------------------------------
# Rails関連
# --------------------------------------------------
gem 'rails', '5.0.6'
gem 'turbolinks', '~> 5'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'json', git: 'https://github.com/flori/json', branch: 'v1.8'

# --------------------------------------------------
# アセット関連
# --------------------------------------------------
group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.2'
end

# --------------------------------------------------
# 本番関連
# --------------------------------------------------
#

# --------------------------------------------------
# 開発環境関連
# --------------------------------------------------
group :development do
  gem 'web-console', '>= 3.3.0'
end
group :test do
  gem 'rails-controller-testing'
end
group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
# gem 'bullet'       #N+1問題を監視
end

# --------------------------------------------------
# ライブラリ関連
# --------------------------------------------------
gem 'sorcery'     #認証
gem 'thinreports' #帳票出力
