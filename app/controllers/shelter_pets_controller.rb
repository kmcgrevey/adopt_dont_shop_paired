class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    # @shelter = Shelter.find(params[:shelter_id])
    # pet = @shelter.pets.create(pet_params)
    # redirect_to "/shelters/#{@shelter.id}/pets"

    @shelter = Shelter.find(params[:shelter_id])
    pet = @shelter.pets.create(pet_params)
    if pet.save
      redirect_to "/shelters/#{@shelter.id}/pets"
    else
      flash.now[:error] = pet.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex)
  end
end
