class UserSession < Authlogic::Session::Base
  
  attr_accessor :remote_ip
  attr_reader :session_id

  after_create :do_after_create
  
  def log_session
    @session_id = ActiveSupport::SecureRandom.hex(20)
    UserSessionLog.create!({
      :user => user,
      :session_id => session_id,
      :ip_address => remote_ip,
      :login_count => user.login_count
    })
  end

  private

  def do_after_create
    user.last_login_at = DateTime.now
  end
end
