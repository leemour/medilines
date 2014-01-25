class ErrorsController < ApplicationController
  def error_404
    @not_found_path = params[:not_found]
    @page = Page.make_from nil
    @page.title = "Ошибка 404"
    respond_to do |format|
      format.html { render template: 'errors/error_404',
                           layout: 'application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def error_500
  end
end
