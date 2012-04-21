class Admin::UserRegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_filter :authenticate_admin!

  def new

  end
end
