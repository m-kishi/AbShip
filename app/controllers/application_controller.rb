class ApplicationController < ActionController::Base
  before_filter :require_login
  protect_from_forgery with: :exception

  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  def error404
    render 'error404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("\n")
    render 'error500', status: 500, formats: [:html]
  end

  private
  def not_authenticated
    redirect_to login_path, alert: 'Please login first.'
  end
end
