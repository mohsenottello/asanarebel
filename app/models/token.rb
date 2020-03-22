class Token < ApplicationRecord
  validates :token_hash, :customer_name, presence: true
  validates :token_hash, uniqueness: true

  def self.generate_token_hash
    token_hash = SecureRandom.uuid
    return token_hash unless self.find_by(token_hash: token_hash)

    self.generate_token_hash
  end
end
