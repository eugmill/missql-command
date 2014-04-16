require_relative '../feature_helper'

describe 'Level: ', :js => true do

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
                expect(page).to have_content(ActionView::Base.full_sanitizer.sanitize(@level.title))
              end

              it "Level #{stage_number+1} should have a Prompt on its page" do
                @level = Level.find_by(:stage_number => stage_number+1)
                visit "/levels/#{@level.stage_number}"
                expect(page).to have_content(ActionView::Base.full_sanitizer.sanitize(@level.prompt))
                page.should have_no_css("div#next-level-modal.active")
              end

              it "Level #{stage_number+1} should move you to the next level if you enter the correct query" do
                @level = Level.find_by(:stage_number => stage_number+1)
                visit "/levels/#{@level.stage_number}"

                # the title of the level YAML file MUST depend on stage number, not ID
                level_data = YAML.load_file("db/levels/lvl#{stage_number+1}.yml")

                fill_in 'sql-command', :with => level_data["correct_query"]

                click_button 'execute'                

                wait_for_ajax

                page.should have_css("div#next-level-modal.active")
              end

          }
     end

end