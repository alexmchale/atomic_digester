class FeedsController < InheritedResources::Base

  belongs_to :user, optional: true

end
