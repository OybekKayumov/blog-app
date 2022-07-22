class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Post, public: true
    return unless user.present? # additional permissions for logged in users (they can read their own posts)

    can :read, User # all users can view users
    can :read, Post # all users can view posts
    can :read, Comment # all users can view comments
    return unless user.present?

    can :manage, Post, author_id: user.id # only post owners can manage posts
    can :manage, Comment, author_id: user.id # only post owners can manage posts
    return unless user.admin? # additional permissions for administrators

    can :manage, :all
  end
end
