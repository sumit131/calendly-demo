class Profile < ApplicationRecord

  def email_exist?(email)
    Profile.where(email: email).present?
  end

end
