require_relative '../spec_helper'

describe 'Level: ' do

    before :all do     
      @user = FactoryGirl.create(:user)
      @user.save
    end       

    before :each do
      visit '/login'
      fill_in 'Username', :with => @user.user_name
      fill_in 'Password', :with => @user.password
      click_button 'Login'
    end

    describe "Level Prompts, Titles and Level Pages: " do
      # Need to change the harcoded number below to Level.all.count. Some scope issues here.
          10.times { | stage_number |
              it "Level #{stage_number+1} should have a Title on its page" do
                @level = Level.find_by(:stage_number => stage_number+1)
                visit "/levels/#{@level.stage_number}"
                expect(page).to have_content(@level.title)
              end

              it "Level #{stage_number+1} should have a Prompt on its page" do
                @level = Level.find_by(:stage_number => stage_number+1)
                visit "/levels/#{@level.stage_number}"
                expect(page).to have_content(@level.prompt)
              end

              # it "Level #{stage_number+1} should have the first Level Page on its page" do
              #   @level = Level.find_by(:stage_number => stage_number+1)
              #   visit "/levels/#{@level.stage_number}"
              #   expect(page).to have_content(@level.level_pages.first.content)
              # end

          }
     end

      # it 'should show the title, prompt and first level page for each level' do
      #   visit '/login'
      #   fill_in 'Username', :with => @user.user_name
      #   fill_in 'Password', :with => @user.password
      #   click_button 'Login'
      #   Level.order(:stage_number).each_with_index do |level, index|
      #     visit "/levels/#{level.stage_number}"
      #     binding.pry
      #     expect(page).to have_content(level.level_pages.first.content)
      #     binding.pry
      #     expect(page).to have_content(level.title)
      #     expect(page).to have_content(level.prompt)
      #  end

    # Level.order(:stage_number).each_with_index do |level, index|
    #   it "should show the title, prompt and first level page for level #{level.stage_number}" do
    #     visit '/login'
    #     fill_in 'Username', :with => @user.user_name
    #     fill_in 'Password', :with => @user.password
    #     click_button 'Login'
    #     visit "/levels/#{level.stage_number}"
    #     # binding.pry
    #     # expect(page).to have_content(level.level_pages.first.content)
    #     # binding.pry
    #     expect(page).to have_content(level.title)
    #     # expect(page).to have_content(level.prompt)
    #   end
    # end  

    # @levels.each do |level|

      # check for level prompt on page
      # check for level title on page
      # check for level page 1 on page
      # fill in "correct query"; check that the page has congrats

    # it 'should show the instructions for the level' do
    #   visit '/login'
    #   fill_in 'Username', :with => @user.user_name
    #   fill_in 'Password', :with => @user.password
    #   click_button 'Login'
    #   visit '/levels/1'

    #   expect(page).to have_content("Hello Commander, and welcome to the MISSQL COMMAND console!")
    # end

    # it 'will display a link to the second level if user enters the correct query' do
    #   visit '/login'
    #   fill_in 'Username', :with => @user.user_name
    #   fill_in 'Password', :with => @user.password
    #   click_button 'Login'
    #   visit '/levels/1'

    #   fill_in 'sql-command', :with => "SELECT name FROM cities"
    #   click_button 'EXECUTE'
    #   expect(page).to have_content("Congratulations, you passed this challenge!")
    # end

    # it 'will display an error if user enters the wrong query' do
    #   visit '/login'
    #   fill_in 'Username', :with => @user.user_name
    #   fill_in 'Password', :with => @user.password
    #   click_button 'Login'
    #   visit '/levels/1'

    #   fill_in 'sql-command', :with => "SELECT * FROM cities"
    #   click_button 'EXECUTE'
    #   expect(page).to have_no_content("Congratulations, you passed this challenge!")
    #   expect(page).to have_no_content("Move on to the next level >")
    # end

end