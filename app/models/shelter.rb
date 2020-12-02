class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def number_of_apps
    pets.joins(:application_pets)
        .select('application_pets.id')
        .distinct
        .count
  end

  def has_apps
    # pets.joins(:applications)
    # NEED ACTIVERECORD METHOD
    status = []
    pets.each do |pet|
      status << pet.status
    end
    status.include? "Pending"
  end
end
