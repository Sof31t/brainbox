class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    send user.role
  end

  def admin
    can :manage, :all
  end

  def user
   # can [:create, :read, :update], [Article, Dossier]
  end
end