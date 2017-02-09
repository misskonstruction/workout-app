require "rails_helper"

RSpec.feature "Creating Home Page" do
   scenario do
    visit "/"
    
    expect(page).to have_link('Home')
    expect(page).to have_link('Runners Den')
    expect(page).to have_content('Run For Your Life!') 
    expect(page).to have_content('An online running log for your many adventures')
   end
end