class ApplicationController < ActionController::API
  include RailsJwtAuth::AuthenticableHelper
  include RailsAuthorize

  class NotAuthenticatedError < StandardError; end

  rescue_from RailsAuthorize::NotAuthorizedError, with: :render403
  rescue_from RailsJwtAuth::NotAuthorized, with: :render401

  def render403
    head 403
  end

  def render401
    head 401
  end
end
