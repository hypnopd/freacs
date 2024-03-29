class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => t("cancan.not_authorized")
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :alert => t("exceptions.not_found")
  end


end
