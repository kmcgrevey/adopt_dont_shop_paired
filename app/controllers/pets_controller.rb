class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:pet_id])
  end

  def edit
    @pet_to_edit = Pet.find(params[:pet_id])
  end

  def update
    @pet_to_edit = Pet.update(params[:pet_id], pet_params)
    if @pet_to_edit.save
      redirect_to "/pets/#{params[:pet_id]}"
    else
      flash.now[:error] = @pet_to_edit.errors.full_messages.to_sentence
      render :edit
      # redirect_to "/pets/#{pet_to_edit.id}/edit"
    end
  end

  def destroy
    pet_to_delete = Pet.find(params[:pet_id])
    pet_to_delete.destroy
    redirect_to "/pets/"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex)
  end
end


shelter = Shelter.new(shelter_params)
if shelter.save
  redirect_to "/shelters"
else
  flash.now[:error] = shelter.errors.full_messages.to_sentence
  render :new
end
