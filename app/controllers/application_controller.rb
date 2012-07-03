class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_time_zone

  private

  def set_time_zone
    Time.zone = ActiveSupport::TimeZone[-cookies[:timezone].to_i.minutes]
  end
end
