class Admin::UserRegistrationsController < RegistrationsController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_admin!

end
