class Admin < ApplicationRecord
  has_many :leaders
  has_secure_password
  attr_readonly :country_code
  attr_readonly :mobile_number
   validates :email, presence: true,uniqueness: true
 
  validates :mobile_number, presence: true,uniqueness: true

 def generate_password_token!
 self.reset_password_token = generate_token
 self.reset_password_sent_at = Time.now.utc
 save!
end

def password_token_valid?
 (self.reset_password_sent_at + 4.hours) > Time.now.utc
end

def reset_password!(password)
 self.reset_password_token = nil
 self.password = password
 save!
end

private

def generate_token
 SecureRandom.hex(10)
end

end
