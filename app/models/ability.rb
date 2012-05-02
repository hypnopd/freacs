class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.creator?
      can [:create, :update, :read], User
      cannot :read, User, :role => "admin"
      cannot :destroy, User
      can :manage, [AuctionUser, Auction, Item, Condition]
    elsif user.competitor?
      can [:create,:read], User
      can :read, [Auction, Item, Condition]
      cannot :manage, [AuctionUser, Company]
      cannot [:create,:update, :destroy], [Auction, Item, Condition]
    elsif user.creator_viewer?
      cannot [:create, :update, :destroy], :all
    elsif user.competitor_viewer?
      can :read, Auction
      cannot [:create, :update, :destroy], :all
      #cannot :manage, [User, Company]
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
