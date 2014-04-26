class Feed < ActiveRecord::Base

  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :user_id, presence: true

  protect do |user|
    scope { where(user_id: user.id) }

    can :create
    can :read
    can :update
    can :destroy
  end

end
