require 'spec_helper'

describe "go from welcome to stop" do
  let(:trip_one) {FactoryGirl.create(:trip)}
  let(:place){FactoryGirl.create(:place)}
  
  it "can create a trip and add a stop" do
    visit root_path

    click_link "Create a new trip"
    visit new_trips_path

    within (".new-trip") do
      fill_in "Name", with: "Thailand booze cruise"
    end
    click_button "Create trip!"

    expect(page).to have_content "Thailand booze cruise"
    click_link "Add a new stop"
    

    within "form" do
      fill_in "Enter your address", with: "New York, NY, United States"
    end
    click_button "Submit"

    expect(page).to have_content "New York"

    click_link "Create a new Entry"

    fill_in("Title", :with => "Sample Title")
    fill_in("Text", with: "Sample text sample text")
    attach_file "entry_photo", "#{Rails.root}/spec/fixtures/sample.jpg"
    click_button "Create Entry"

    expect(page).to have_content "Sample Title"
    expect(page).to have_content "Sample text sample text"
end