class Level < ActiveRecord::Base

  def clone_for_user(user)
    # checks to see if user has these tables
    # if they dont then it users the user id and the level's master tables
    # to generate new tables
    # instantiates user tables
    # then triggers postgres to magically creates the actual tables
  end

end
