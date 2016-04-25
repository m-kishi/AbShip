class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one  :api_key , dependent: :destroy

  has_many :expenses , dependent: :destroy
  has_many :graphics , dependent: :destroy
  has_many :balances , dependent: :destroy
  has_many :privates , dependent: :destroy
  has_many :energies , dependent: :destroy, class_name: "Energie"
  has_many :summaries, dependent: :destroy

  validates :mail, presence: true
  validates :mail, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: true

  def self.login?(token)
    api_key = ApiKey.find_by_token(token)
    if !api_key || api_key.expired?
      return false
    end
    return !self.find(api_key.user_id).nil?
  end

  def self.find_by_token(token)
    api_key = ApiKey.find_by_token(token)
    return self.find(api_key.user_id)
  end

  def activate
    if !api_key
      return ApiKey.create(user_id: self.id)
    else
      api_key.activate
      api_key.save
      return api_key
    end
  end

end
