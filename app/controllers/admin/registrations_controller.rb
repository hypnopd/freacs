class Admin::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_filter :debug

  def debug
    puts "!!!!DEBUG#{resource_name.inspect}"
  end

  def new
    puts "!!!!RESOURCE #{self.resource_name}"
    super
  end

end
