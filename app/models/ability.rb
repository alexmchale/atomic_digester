class Ability

  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Feed, user_id: user.id
      can :manage, User, id: user.id
    end
  end

end
