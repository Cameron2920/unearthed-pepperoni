class ApplicationController < ActionController::API
  before_filter :set_access_control_headers

  def set_access_control_headers
    if request.headers['Origin']
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin']
    end
    response.headers['Access-Control-Allow-Methods'] = 'GET, PUT, POST, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, x-csrf-token'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Expose-Headers'] = 'x-csrf-token'
  end
  
  def cors_preflight_check
    head(:ok) if request.request_method == 'OPTIONS'
  end
end
