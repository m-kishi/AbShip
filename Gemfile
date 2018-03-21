source 'https://rubygems.org'

# --------------------------------------------------
# Rails関連
# --------------------------------------------------
gem 'rails', github: 'rails/rails', branch: '4-2-stable'
gem 'turbolinks'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'json', git: 'https://github.com/flori/json', branch: 'v1.8'

# --------------------------------------------------
# アセット関連
# --------------------------------------------------
group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'
end

# --------------------------------------------------
# 本番関連
# --------------------------------------------------
#

# --------------------------------------------------
# 開発環境関連
# --------------------------------------------------
group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'spring'
# gem 'bullet'       #N+1問題を監視
  gem 'quiet_assets' #assetsログを抑制
  gem 'web-console', '~> 2.0'
end

# --------------------------------------------------
# ライブラリ関連
# --------------------------------------------------
gem 'sorcery'     #認証
gem 'thinreports' #帳票出力
