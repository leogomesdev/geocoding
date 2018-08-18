class User < ApplicationRecord
  before_create -> {self.token = generate_token}
  validates_presence_of :name

  private

  def generate_token
    loop do
      token = SecureRandom.hex
      return token unless User.exists?({token: token})
    end
  end
end
