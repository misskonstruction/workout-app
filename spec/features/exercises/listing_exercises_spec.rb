require "rails_helper"

RSpec.feature "Listing Exercise" do
  before do
  @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
  login_as(@john)
  
  @e1 = @john.exercises.create(duration_in_min: 45,
                               workout: "Trail Run",
                               workout_date: Date.today)
                               
  @e2 = @john.exercises.create(duration_in_min: 55,
                               workout: "Run with Dogs",
                               workout_date: 2.days.ago)
                               
  @e3 = @john.exercises.create(duration_in_min: 60,
                               workout: "Beach Run",
                               workout_date: 8.days.ago)
                               
  
  
  end
  
  scenario "shows user's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
  
    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
    
    expect(page).not_to have_content(@e3.duration_in_min)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)
  end
  
  scenario "shows no exercise if none created" do
    @john.exercises.delete_all
    
    visit '/'
    
    click_link 'My Lounge'
    
    expect(page).to have_content('No Workouts Yet')
  end
end

