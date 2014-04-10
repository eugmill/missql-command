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
    before :each do 
      @user = FactoryGirl.build(:user)
    end 

    it "should log you in if you make a new account" do
      visit '/users/new'
      fill_in 'User name', :with => @user.user_name
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
      fill_in 'Password confirmation', :with => @user.password
      click_button 'Create User'
      new_user = User.find_by(:email => @user.email)
      expect(current_path).to eq("/users/#{new_user.id}")
    end

    it "should tell you if a username is already taken" do
      @user.save
      visit '/users/new'
      fill_in 'User name', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      expect(current_path).to eq("/users/new")
      expect(page).to have_content("User name is already taken.")
    end

    it "should tell you if your password doesn't match the confirmation" do
      pending
    end

    it "should tell you if your email has already been used" do
      pending
    end

  end




end