require 'rails_helper'

RSpec.describe "test it has a main directory", type: :feature do
  it "has a welcome page" do
    visit "/"

    expect(page).to have_content("Adopt Don't Shop")
  end
end
