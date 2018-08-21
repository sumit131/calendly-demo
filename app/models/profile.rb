class Profile < ApplicationRecord

  def self.email_exist?(email)
    Profile.where(email: email).present?
  end

end
