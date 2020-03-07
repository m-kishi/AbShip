source 'https://rubygems.org'

# --------------------------------------------------
# Rails関連
# --------------------------------------------------
gem 'rails', '6.0.2.1'
gem 'turbolinks', '~> 5'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', group: :doc
gem 'json', git: 'https://github.com/flori/json'

# --------------------------------------------------
# アセット関連
# --------------------------------------------------
group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'coffee-rails'
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
  gem 'puma'
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
gem 'bundle_outdated_formatter' #bundle outdated の出力形式変換
