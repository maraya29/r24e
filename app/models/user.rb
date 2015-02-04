class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.login_field = :email
    config.merge_validates_length_of_password_field_options({:minimum => 6, :maximum => 20})
  end 

  validates_presence_of :first_name, :last_name, :email
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
