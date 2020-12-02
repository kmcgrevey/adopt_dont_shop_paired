require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it {should have_many :pets}
  end

  describe 'instance methods' do
    before(:each) do
      @paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                              address: "1234 Market Street",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80014")

      @pet_1 = @paulas_shelter.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                              name: "Penelope",
                              description: "A face only everyone could love!",
                              approx_age: 1,
                              sex: "female")
  
      @pet_2 = @paulas_shelter.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                              name: "Petey",
                              description: "Rubber baby bacon booties!",
                              approx_age: 1,
                              sex: "male")
    end
    
    it '.pet_count' do
      expect(@paulas_shelter.pet_count).to eq(2)
    end

    it '.average_rating' do
      review_1 = @paulas_shelter.reviews.create!(title: "Best Shelter",
                                      rating: 5,
                                      content: "These guys really know how to run a shelter!",
                                      picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

      review_2 = @paulas_shelter.reviews.create!(title: "Whatever, man",
                                      rating: 3,
                                      content: "The employees gave me an attitude. No one talks to me like that!")

      expect(@paulas_shelter.average_rating).to eq(4)
    end

    it '.number_of_apps' do
      burts_barn = Shelter.create!(name: "Burt's Barn",
                        address: "123 Sesame Street",
                        city: "New York",
                        state: "NY",
                        zip: "12345")

      pet_3 = burts_barn.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                          name: "Caesar",
                          approx_age: "4",
                          description: "Denver",
                          sex: "Male")

      application_1 = Application.create!(name: "John Hutchinson",
                                  address: "4089 S. Broadway Street",
                                  city: "Philadelphia",
                                  state: "Pennsylvania",
                                  zip: "19050",
                                  phone: "215-367-8891",
                                  description: "I am loving and will provide a good home")

      application_2 = Application.create!(name: "Mike Jones",
                                  address: "8091 Charles Street",
                                  city: "Baltimore",
                                  state: "Maryland",
                                  zip: "20239",
                                  phone: "410-743-8819",
                                  description: "I am the single greatest pet owner in the history of owning pets")
      
      application_3 = Application.create!(name: "Foo Bar",
                                  address: "123 Sesame Street",
                                  city: "Brooklyn",
                                  state: "New York",
                                  zip: "12345",
                                  phone: "987-654-3210",
                                  description: "Fuhgedaboudit")

      application_1.pets << @pet_1
      application_2.pets << @pet_1
      application_3.pets << pet_3

      expect(@paulas_shelter.number_of_apps).to eq(2)
      expect(burts_barn.number_of_apps).to eq(1)
    end

    it '.has_apps' do
      pet_pend = @paulas_shelter.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                            name: "Penelope",
                            description: "A face only everyone could love!",
                            approx_age: 1,
                            sex: "female",
                            status: "Pending")

      application_1 = Application.create!(name: "John Hutchinson",
                                  address: "4089 S. Broadway Street",
                                  city: "Philadelphia",
                                  state: "Pennsylvania",
                                  zip: "19050",
                                  phone: "215-367-8891",
                                  description: "I am loving and will provide a good home")

      application_1.pets << [@pet_1, pet_pend]

      expect(@paulas_shelter.has_apps).to eq(true)
    end
  end
end
