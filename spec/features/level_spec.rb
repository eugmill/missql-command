require_relative '../spec_helper'

describe 'Level' do

  describe 'the first level works' do

    before :each do     
      @user = FactoryGirl.create(:user)
      @user.save
    end       

    it 'should show the instructions for the level' do
      visit '/login'
      fill_in 'Username', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      visit '/levels/1'

      expect(page).to have_content("Hello Commander! Welcome to Missql Command!")
    end

    it 'will display a link to the second level if user enters the correct query' do
      visit '/login'
      fill_in 'Username', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      visit '/levels/1'

      fill_in 'sql-command', :with => "SELECT * FROM cities"
      click_button 'EXECUTE'
      expect(page).to have_content("Congratulations, you passed this challenge!")
      expect(page).to have_content("Move on to the next level >")
    end

    it 'will display an error if user enters the wrong query' do
      visit '/login'
      fill_in 'Username', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
      visit '/levels/1'

      fill_in 'sql-command', :with => "SELECT * FROM cities"
      click_button 'EXECUTE'
      expect(page).to have_content("Congratulations, you passed this challenge!")
      expect(page).to have_content("Move on to the next level >")
    end

  end

end



