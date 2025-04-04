class ApplicationController < ActionController::Base
  helper ActionView::Helpers::DateHelper

  helper_method :current_user

  def current_user
    @current_user ||= User.first_or_create!(email: "dev@example.com")
  end
end
