class Api::ApplicationController < ApplicationController
    # When making POST, DELETE & PATCH requests to
    # controllers, Rails that an authenticity token
    # be provided. This doesn't make sense for a public
    # HTTP API. We'll use the following to skip
    # that verification.
    
    skip_before_action(:verify_authenticity_token)
  
    private
    def authenticate_user!
      if not current_user.present?
        render(json: {status: 401}, status: 401) # Unauthorized
      end
    end
  end
  