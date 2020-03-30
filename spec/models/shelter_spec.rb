require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it {should have_many :pets}
  end

  describe 'instance methods' do
    it '.pet_count' do

      paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                              address: "1234 Market Street",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80014")

      pet_1 = paulas_shelter.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                              name: "Penelope",
                              description: "A face only everyone could love!",
                              approx_age: 1,
                              sex: "female")

      pet_2 = paulas_shelter.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                              name: "Petey",
                              description: "Rubber baby bacon booties!",
                              approx_age: 1,
                              sex: "male")

      expect(paulas_shelter.pet_count).to eq(2)
    end

    it '.average_rating' do

      paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                              address: "1234 Market Street",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80014")

      review_1 = paulas_shelter.reviews.create!(title: "Best Shelter",
                                      rating: 5,
                                      content: "These guys really know how to run a shelter!",
                                      picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

      review_2 = paulas_shelter.reviews.create!(title: "Whatever, man",
                                      rating: 3,
                                      content: "The employees gave me an attitude. No one talks to me like that!")

      expect(paulas_shelter.average_rating).to eq(4)
    end
  end
end
