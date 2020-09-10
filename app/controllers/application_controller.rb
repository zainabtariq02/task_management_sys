# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :prevent_caching

  private

  def prevent_caching
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
