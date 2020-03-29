class ShelterController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to "/shelters"
    else
      flash.now[:error] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @shelter_to_edit = Shelter.find(params[:id])
  end

  def update
    shelter_to_edit = Shelter.update(params[:id], shelter_params)
    redirect_to "/shelters/#{params[:id]}"
  end

  def destroy
    shelter_to_delete = Shelter.find(params[:id])
    shelter_to_delete.destroy
    redirect_to "/shelters/"
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
