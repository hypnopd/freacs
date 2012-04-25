class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_filter :check_create_permissions, :only => [:new, :create, :cancel]


  def create
    super
    resource.update_attribute :parent_id, params[:user][:parent_id] unless resource.errors
  end

  def check_create_permissions
    if current_user
      unless current_user.admin? || current_user.creator?
        raise CanCan::AccessDenied
      end
    else
      raise CanCan::AccessDenied
    end
  end

end
