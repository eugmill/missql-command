require_relative '../spec_helper'

describe "Session" do  

  describe "login" do
  
    before :each do 
      @user = FactoryGirl.create(:user)
      @user.save
    end       

    it "should redirect to user's profile upon successful login" do
      visit '/login'
      fill_in 'Username', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(current_path).to eq("/users/#{@user.id}")
    end

    it "should flash an error if email or password is incorrect" do
      visit '/login'
      fill_in 'Username', :with => "gargdfsdfsadf"
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(page).to have_content("Email or password is incorrect")
    end

  end

  describe "header changes depending on login" do
    
  end


end