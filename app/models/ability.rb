# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      cannot :manage, Company
      cannot :manage, :admin_user
      can :read, Co2EmissionFactor

      if user.admin?
        can :manage, :all
      end
    end
  end
end
