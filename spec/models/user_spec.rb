require 'spec_helper'

describe User do
  before :each do 
    @user = FactoryGirl.create(:user)
  end 

  it "should have a user database after creation" do
    expect(@user.user_database).not_to be_nil
  end

  it "should return its current level" do
    expect(@user.current_level).to eq(@user.user_database.level)
  end

end