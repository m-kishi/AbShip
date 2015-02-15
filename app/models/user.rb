class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :mail, presence: true
  validates :mail, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: true
end
