require 'rails_helper'

RSpec.describe "test pet info can be updated", type: :feature do
  it "updates a pet's information on show page" do

    paulas_shelter = Shelter.create(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    hadrian = Pet.create(image: "https://upload.wikimedia.org/wikipedia/commons/3/34/Labrador_on_Quantock_%282175262184%29.jpg",
                        name: "Hadrian",
                        approx_age: "9",
                        city: "Denver",
                        sex: "Male",
                        shelter: paulas_shelter,
                        description: "Hadrian is loyal and friendly",
                        status: "Adoptable")


    visit "/pets/#{hadrian.id}"

    click_link "Update Pet"

    expect(current_path).to eq("/pets/#{hadrian.id}/edit")

    fill_in "Image", with: "https://www.gannett-cdn.com/presto/2019/01/09/USAT/ebae0b75-b22d-4604-9afb-3047d1f8b6f2-DF-18447.jpg?width=660&height=441&fit=crop&format=pjpg&auto=webp"
    fill_in "Name", with: "Cassia"
    fill_in "Approx age", with: "8"
    fill_in "Sex", with: "Female"
    fill_in "Description", with: "Cassia is an explorer with a heart of gold!"

    click_button "Update Pet"

    expect(current_path).to eq("/pets/#{hadrian.id}")

    expect(page).to have_content("Cassia")
    expect(page).to have_css("img[src*='https://www.gannett-cdn.com/presto/2019/01/09/USAT/ebae0b75-b22d-4604-9afb-3047d1f8b6f2-DF-18447.jpg?width=660&height=441&fit=crop&format=pjpg&auto=webp']")
    expect(page).to have_content("Cassia is an explorer with a heart of gold!")
    expect(page).to have_content("8")
    expect(page).to have_content("Female")

    expect(page).to_not have_content("Hadrian")
    expect(page).to_not have_css("img[src*='#{hadrian.image}']")
    expect(page).to_not have_content("Hadrian is loyal and friendly")
    expect(page).to_not have_content("9")
    expect(page).to_not have_content("Male")
  end
end
