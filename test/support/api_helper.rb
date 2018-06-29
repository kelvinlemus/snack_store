module ApiHelper
  def json
    response.parsed_body
  end

  def token_for(user)
    Doorkeeper::AccessToken.create!(resource_owner_id: user.id, expires_in: 24.hours)
  end

  def common_user
    @common_user ||= User.find_by_email("john.doe@example.com")
  end

  def admin_user
    @admin_user ||= User.find_by_email("admin@example.com")
  end
end