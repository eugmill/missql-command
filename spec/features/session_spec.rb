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
    pending
  end


  describe "creating a new account" do
    before :all do 
      # @user = FactoryGirl.create(:user)
      # @user.save
    end 

    it "should log you in if you make a new account" do
      visit '/users/new'
      fill_in 'User name', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      fill_in 'Password confirmation', :with => @user.password
      click_button 'Create User'
      expect(current_path).to eq("/users/#{@user.id}")
    end

    it "should tell you if a username is already taken" do
      visit '/users/new'
      fill_in 'User name', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(current_path).to eq("/users/new")
      expect(page).to have_content("User name is already taken.")
    end

    it "should tell you if your password doesn't match the confirmation" do

    end

    it "should tell you if your email has already been used" do

    end

  end




end