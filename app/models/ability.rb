# frozen_string_literal: true

# Ability class
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else

      can :read, Task, ['assignee_user_id = (?) OR reviewer_user_id = (?) OR created_by_user_id = (?)', user.id, user.id, user.id] do |task| 
      task.assignee_user_id == user.id || task.reviewer_user_id == user.id || task.created_by_user_id == user.id
      end

      can :create, Task
      can :destroy, Task, created_by_user_id: user.id
      can :update, Task, assignee_user_id: user.id

      can :in_progress, Task, assignee_user_id: user.id
      can :complete, Task, ['assignee_user_id = (?) OR reviewer_user_id = (?)',user.id, user.id] do |task|
        task.assignee_user_id == user.id || task.reviewer_user_id == user.id

      end
    end

    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
