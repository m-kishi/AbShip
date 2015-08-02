class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :expenses , dependent: :destroy
  has_many :graphics , dependent: :destroy
  has_many :balances , dependent: :destroy
  has_many :privates , dependent: :destroy
  has_many :summaries, dependent: :destroy

  validates :mail, presence: true
  validates :mail, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: true
end
