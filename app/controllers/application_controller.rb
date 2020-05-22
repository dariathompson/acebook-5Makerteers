# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  around_action :set_time_zone

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'London'
    Time.use_zone(time_zone, &block)
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user) # your path
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  def owner?(item_owner)
    current_user.id == item_owner
  end
end
