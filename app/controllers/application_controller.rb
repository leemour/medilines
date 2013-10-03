# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery


  # Handling Errors
  #unless Rails.application.config.consider_all_requests_local
  #  rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  #  rescue_from ActionController::RoutingError,
  #              ActionController::UnknownController,
  #              ::AbstractController::ActionNotFound,
  #              ActiveRecord::RecordNotFound,
  #              with: lambda { |exception| render_error 404, exception }
  #end
  #
  #private
  #def render_error(status, exception)
  #  @page = Page.make_from nil
  #  @page.title = "Ошибка #{status}"
  #  @not_found_path = request.fullpath
  #  #@exception = exception
  #  respond_to do |format|
  #    format.html { render template: "errors/error_#{status}",
  #                         layout: 'application', status: status }
  #    format.all { render nothing: true, status: status }
  #  end
  #end
end
