require_relative '../spec_helper'

describe "Session" do  

  describe "login" do

    before :all do 
      User.destroy_all
      @user = FactoryGirl.create(:user)
      @user.save
    end 
  
    it "should redirect to first level upon successful login" do
      visit '/login'
      fill_in 'email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(current_path).to eq("/levels/1")
    end

    it "should flash an error if email or password is incorrect" do
      visit '/login'
      fill_in 'email', :with => "gargdfsdfsadf"
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(page).to have_content("Email or password is incorrect")
    end

  end 

  describe "header changes depending on login" do

    before :each do
      User.destroy_all
      @user = FactoryGirl.create(:user)
      @user.save
    end 

    it "should show the sign up and login links when a user is logged out" do
      visit '/'
      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
      expect(page).to have_no_content("Logout")      
    end

    it "should show to logout link when a user is logged in" do
      visit '/'
      visit '/login'
      fill_in 'email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(page).to have_content("Logout")
      expect(page).to have_no_content("Login")
      expect(page).to have_no_content("Sign Up")
    end

  end

  describe "creating a new account" do
    before :each do 
      User.destroy_all
      @user = FactoryGirl.build(:user)
    end 

    it "should log you in if you make a new account" do
      visit '/users/new'
      fill_in 'Username', :with => @user.user_name
      fill_in 'user_email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'user_password_confirmation', :with => @user.password
      click_button 'Create User'
      new_user = User.find_by(:email => @user.email)
      expect(current_path).to eq("/levels/1")
    end

    it "should tell you if a username is already taken" do
      @user.save
      visit '/users/new'
      fill_in 'Username', :with => @user.user_name
      fill_in 'user_email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'user_password_confirmation', :with => @user.password
      click_button 'Create User'
      expect(page).to have_content("User name has already been taken")
    end

    it "should redirect you to the homepage if you're logged in" do
      @user.save
      visit '/login'
      fill_in 'email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      visit '/users/new'
      expect(current_path).to eq("/")
    end

    it "should tell you if your password doesn't match the confirmation" do
      visit '/users/new'
      fill_in 'Username', :with => @user.user_name
      fill_in 'user_email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'user_password_confirmation', :with => "lolllll"
      click_button 'Create User'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "should tell you if your email has already been used" do
      visit '/users/new'
      fill_in 'Username', :with => @user.user_name
      fill_in 'user_email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'user_password_confirmation', :with => @user.password
      click_button 'Create User'

      click_link('Logout')
      visit '/users/new'
      fill_in 'Username', :with => @user.user_name
      fill_in 'user_email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'user_password_confirmation', :with => @user.password
      click_button 'Create User'
      expect(page).to have_content("Email has already been taken")
      expect(page).to have_content("User name has already been taken")
    end

  end

end