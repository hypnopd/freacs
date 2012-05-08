class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at, :role, :company
  has_ancestry
  belongs_to :company
  has_many :auction_users
  has_many :auctions, :through => :auction_users

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

  def auction_admin?
    role == ROLES[:admin] || role == ROLES[:creator]
  end

  def auction_user?
    role != ROLES[:admin] || role != ROLES[:creator]
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
    #admin -> admin, creator, competitor
    if admin?
      {:admin => I18n.t("users.admin"), :creator => I18n.t("users.creator"), :competitor => I18n.t("users.competitor")}
    #creator -> creator, competitor, creator_viewer
    elsif creator?
      {:creator => I18n.t("users.creator"), :competitor => I18n.t("users.competitor"), :creator_viewer=> I18n.t("users.creator_viewer")}
    #competitor -> competitor_viewer
    elsif competitor?
      {:competitor_viewer => I18n.t("users.competitor_viewer")}
    end
  end

  def able_companies
    result = []
    if auction_admin?
      Company.all.each{|c| result << [c.name,"#{c.id}"] }
      puts "#{result}"
    elsif competitor?
      result << [company.name, "#{company.id}"]
    end
    result
  end
end
