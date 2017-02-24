require "rails_helper"

RSpec.feature "Creating Invalid Exercise" do
    before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
  end 
    
  scenario "with invalid inputs" do
    visit "/"
        
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
        
    fill_in "Duration", with: ""
    fill_in "Workout details", with: ""
    fill_in "Activity date", with: ""
        
    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details cant be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
end