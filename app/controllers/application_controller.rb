class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from Exception do |exception|
    begin
      if exception.kind_of? CanCan::AccessDenied
        redirect_to root_url, alert: t('errors.access_denied')
      else
        @title = t('errors.title')
        error = "#{exception.class}: #{exception.message}\n\n"
        exception.backtrace.each { |l| error << "#{l}\n" }

        unless response.redirect_url
          render template: 'shared/show_error', locals: {error: exception}
        end

        logger.error(error)
      end

    # En caso que la presentación misma de la excepción no salga como se espera
    rescue => ex
      error = "#{ex.class}: #{ex.message}\n\n"
      ex.backtrace.each { |l| error << "#{l}\n" }

      logger.error(error)
    end
  end
end
