class Ability
  include CanCan::Ability
  include Mongoid::Document

  def initialize(user)
    unless user
      user = User.new
      user.access = 'none'
    end
      can :read, :all

      if user.basic?
        can :create, [Type, Thing, Review]
        can :manage, Type, owner: user
        can :manage, Thing, owner: user
        can :manage, Review, user: user
      end

      if user.admin?
        can :manage, :all
      end

    #user ||= User.new # guest user (not logged in)
    #if user.has_role? :admin
    #  can :manage, :all
    #else
    #  can :read, :all
    #end

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
