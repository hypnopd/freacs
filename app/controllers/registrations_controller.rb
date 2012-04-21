class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_scope!
  skip_before_filter :require_no_authentication

end
