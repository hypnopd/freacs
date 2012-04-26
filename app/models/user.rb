class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at, :role, :company
  has_ancestry
  belongs_to :company

  ROLES = {:admin => "admin",
           :creator => "creator",
           :creator_viewer => "creator_viewer",
           :competitor => "competitor",
           :competitor_viewer => "competitor_viewer"
  }

  def role?(role_name)
    if ROLES.include?(role_name.to_sym)
      role == role_name if role_name.is_a?(String)
    else
      raise Exception::IndexError::KeyError
    end
  end

  def has_name?
    name || surname
  end

  def admin?
    role == ROLES[:admin]
  end

  def creator?
    role == ROLES[:creator]
  end

  def creator_viewer?
    role == ROLES[:creator_viewer]
  end

  def competitor?
    role == ROLES[:competitor]
  end

  def competitor_viewer?
    role == ROLES[:competitor_viewer]
  end

  def able_roles
    #admin can register admin, creator, competitor
    if admin?
      return {:admin => I18n.t("users.admin"), :creator => I18n.t("users.creator"), :competitor => I18n.t("users.competitor")}
    #creator can register creator, competitor
    elsif creator?
      return {:creator => I18n.t("users.creator"), :competitor => I18n.t("users.competitor")}
    end
  end
end
