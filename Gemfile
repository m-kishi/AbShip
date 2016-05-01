source 'https://rubygems.org'

# --------------------------------------------------
# Rails関連
# --------------------------------------------------
gem 'rails', '4.2.0'
gem 'turbolinks'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

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
# ------------------------------------------------------------
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

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
