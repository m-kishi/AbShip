class ApiKey < ApplicationRecord
  belongs_to :user

  before_create :activate
  before_create :token_generate

  def expired?
    self.expires_at < DateTime.now
  end

  def activate
    self.expires_at = DateTime.now + 30.minute
  end

  private
  def token_generate
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

end
