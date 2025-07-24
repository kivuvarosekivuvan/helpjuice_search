class ApplicationController < ActionController::API
  # pulling in the forgery‐protection module
  include ActionController::RequestForgeryProtection

  # using a null session for unverified (JSON) requests
  protect_from_forgery with: :null_session
end
