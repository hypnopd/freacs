class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_scope!
  skip_before_filter :require_no_authentication

  def new
    super
  end

  def create
    super
    resource.update_attribute :parent_id, params[:user][:parent_id]
  end

end
