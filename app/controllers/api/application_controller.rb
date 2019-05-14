class Api::ApplicationController < ApplicationController
  # When making POST, DELETE & PATCH requests to
  # controllers, Rails that an authenticity token
  # be provided. This doesn't make sense for a public
  # HTTP API. We'll use the following to skip
  # that verification.
  
  skip_before_action(:verify_authenticity_token)

  # rescue_from(<error-class>, with: <method-name>)
  # Use `rescue_from` in a controller to prevent
  # an error of class <error-class> from crashing your
  # Rails application and do something else instead.

  # The <method-name> is a method that will the handle error
  # and do whatever you need instead of crashing.
  rescue_from(ActiveRecord::RecordInvalid, with: :record_invalid)

  private
  def authenticate_user!
    if not current_user.present?
      render(json: {status: 401}, status: 401) # Unauthorized
    end
  end

  def record_invalid(error)
    # Use `binding.pry` to stop your program that at its location
    # and open a `pry` REPL right there. You'll have access to scope
    # of the app where `binding.pry` located.

    # It requires the gems `pry` and `pry-rails` to be installed.
    # binding.pry

    # For a ActiveRecord::InvalidRecord error, the .record
    # method returns the **model instance** that failed validation
    # and raised the error.
    invalid_record = error.record
    errors = invalid_record.errors.map do |field, message|
      {
        type: error.class.to_s,
        record_type: invalid_record.class.to_s,
        field: field,
        message: message
      }
    end

    render(
      json: { status: 422, errors: errors },
      status: 422
    )
  end
end
