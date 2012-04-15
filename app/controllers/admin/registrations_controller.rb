class Admin::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_admin!
  skip_before_filter :require_no_authentication

end
